let
  outputs = root.mapPopsLayouts super.pops;
in
{
  inherit (outputs)
    srvos
    nixosModules
    nixosProfiles
    darwinModules
    darwinProfiles
    homeProfiles
    homeModules
    devshellModules
    devshellProfiles
  ;

  units = {
    inherit (outputs) configs;
    nixos = {
      inherit (outputs) nixosProfiles nixosModules;
    };
    darwin = {
      inherit (outputs) darwinProfiles darwinModules;
    };
    home-manager = {
      inherit (outputs) homeProfiles homeModules;
    };
    flake-parts = {
      inherit (outputs.flake-parts) profiles modules;
    };
    devshell = {
      inherit (outputs) devshellProfiles devshellModules;
    };
  };

  dotfiles = inputs.self.outPath + "/dotfiles";

  # aliases
  __inputs__ = outputs.loadInputs;
  flakeModules = outputs.flake-parts.profiles;
  flakeProfiles = outputs.flake-parts.modules;
}
