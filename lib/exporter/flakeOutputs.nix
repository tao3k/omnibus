let
  outputs =
    let
      f = p: lib.mapAttrs (_: v: v.layouts.default) (lib.removeAttrs p [ ]);
    in
    f super.pops
    // {
      flake-parts = f super.pops.flake-parts;
      devshell = f super.pops.devshell;
    }
  ;
in
{
  inherit (outputs) srvos;

  units = {
    inherit (outputs) configs;
  };

  __inputs__ = super.pops.loadInputs.outputs;

  dotfiles = inputs.self.outPath + "/dotfiles";

  devshellModules = outputs.devshell.loadModules;
  devshellProfiles = outputs.devshell.loadProfiles;

  flakePartsProfiles = outputs.flake-parts.loadProfiles;
  flakePartsModules = outputs.flake-parts.loadModules;

  nixosModules = outputs.loadNixOSModules;
  nixosProfiles = outputs.loadNixOSProfiles;

  darwinModules = outputs.loadDarwinModules;
  darwinProfiles = outputs.loadDarwinProfiles;

  homeProfiles = outputs.loadHomeProfiles;
  homeModules = outputs.loadHomeModules;
}
