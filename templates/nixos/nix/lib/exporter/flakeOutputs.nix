let
  filterConfigs =
    config:
    lib.pipe super.hosts [
      (lib.filterAttrs (_: v: v ? "${config}"))
      (lib.mapAttrs (_: v: v.${config}))
    ];
  inherit (omnibus.lib) mapPopsLayouts;
in
(mapPopsLayouts super.pops)
// {
  nixosConfigurations = filterConfigs "nixosConfiguration";

  darwinConfigurations = filterConfigs "darwinConfiguration";

  local = eachSystem (
    system:
    let
      inputs = (super.inputs.setSystem system).outputs;
      loadDataAll =
        (super.omnibus.lib.addLoadExtender { load.inputs = inputs; })
        .layouts.default.loadDataAll;
    in
    {
      data =
        (loadDataAll.addLoadExtender {
          load.src = inputs.self.outPath + "/local/data";
        }).layouts.default;
    }
  );

  packages = eachSystem (
    system:
    let
      inputs = (super.inputs.setSystem system).outputs;
    in
    (
      (flops.haumea.pops.default.setInit {
        src = ../../packages;
        loader = _: path: inputs.nixpkgs.callPackage path { };
        transformer = [ (_cursor: dir: if dir ? default then dir.default else dir) ];
      })
    ).layouts.default
  );
}
