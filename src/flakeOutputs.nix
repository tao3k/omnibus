let
  outputs = root.lib.mapPopsExports super.pops;
in
{
  inherit (super) load;
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
    flake
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

  dotfiles = projectDir + "/dotfiles";

  # aliases
  flakeModules = outputs.flake-parts.profiles;
  flakeProfiles = outputs.flake-parts.modules;
}
