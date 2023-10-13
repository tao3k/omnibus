let
  filterConfigs =
    config:
    lib.pipe self.hosts [
      (lib.filterAttrs (_: v: v ? "${config}"))
      (lib.mapAttrs (_: v: v.${config}))
    ];
in
{
  hosts =
    (inputs.omnibus.pops.exporter.addLoadExtender {
      load = {
        src = inputs.self.outPath + "/nixos/hosts";
        inputs = inputs // {
          inputs.self.lib = root;
          omnibus = inputs.omnibus // {
            self = root.omnibus.lib.layouts.default;
          };
        };
      };
    }).layouts.default;

  nixosConfigurations = filterConfigs "nixosConfiguration";

  darwinConfigurations = filterConfigs "darwinConfiguration";

  local = eachSystem (
    system:
    let
      inputs = (super.inputs.setSystem system).outputs;
      loadDataAll =
        (omnibus.pops.lib.addLoadExtender {
          load = {
            inputs = {
              inputs.nixpkgs = inputs.nixpkgs.legacyPackages.${system};
            };
          };
        }).layouts.default.loadDataAll;
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
