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
    (inputs.omnibus.exporters.addLoadExtender {
      src = ../../nixos/hosts;
      inputs = inputs // {
        self'.lib = super;
        omnibus = inputs.omnibus.lib // {
          lib = super.omnibus.lib.outputs.default;
        };
      };
    }).outputs.default;

  nixosConfigurations = filterConfigs "nixosConfiguration";

  darwinConfigurations = filterConfigs "darwinConfiguration";

  local = eachSystem (
    system:
    let
      inputs = (super.inputs.setSystem system).outputs;
      loadDataAll =
        (omnibus.lib.addLoadExtender {
          inputs = {
            nixpkgs = inputs.nixpkgs.legacyPackages.${system};
          };
        }).outputs.default.loadDataAll;
    in
    {
      data =
        (loadDataAll.addLoadExtender { src = ../../local/data; }).outputs.default;
    }
  );

  packages = eachSystem (
    system:
    let
      inputs = (super.inputs.setSystem system).outputs;
    in
    (
      (flops.haumea.pops.default.setInit {
        src = ../packages;
        loader = _: path: inputs.nixpkgs.callPackage path { };
        transformer = [ (_cursor: dir: if dir ? default then dir.default else dir) ];
      })
    ).outputs.default
  );
}
