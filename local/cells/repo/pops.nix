let
  inherit (inputs) nixpkgs;
  inputs' = (inputs.omnibus.pops.flake.setSystem nixpkgs.system).inputs;
in
{
  devshellProfiles =
    (inputs.omnibus.pops.devshellProfiles.addLoadExtender {
      load.inputs.inputs = inputs';
    }).addExporter
      {
        exports = {
          self =
            (inputs.omnibus.pops.devshellProfiles.addLoadExtender {
              load.inputs = {
                inputs = inputs';
              };
            });
        };
      };
  configs = inputs.omnibus.pops.configs.addLoadExtender {
    load.inputs.inputs = inputs';
  };
}
