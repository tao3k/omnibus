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
  devshellModules = outputs.devshell.loadModules;
  devshellProfiles = outputs.devshell.loadProfiles;

  flake-partsProfiles = outputs.flake-parts.loadProfiles;

  nixosModules = outputs.loadNixOSModules;
  nixosProfiles = outputs.loadNixOSProfiles;

  homeProfiles = outputs.loadHomeProfiles;
  homeModules = outputs.loadHomeModules;
}
