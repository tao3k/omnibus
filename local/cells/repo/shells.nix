/* This file holds reproducible shells with commands in them.

   They conveniently also generate config files in their startup hook.
*/
{ inputs, cell }:
let
  inherit (inputs.std) lib;
  inherit (inputs) nixpkgs;
  devshellProfiles =
    let
      __inptus__ = (inputs.omnibus.pops.flake.setSystem nixpkgs.system).inputs;
    in
    (inputs.omnibus.devshell.loadProfiles.addLoadExtender {
      inputs = {
        inherit (__inptus__) fenix;
        nixpkgs = __inptus__.nixpkgs.legacyPackages;
      };
    }).exports.default;
in
{
  # Tool Homepage: https://numtide.github.io/devshell/
  default = lib.dev.mkShell {
    name = "omnibus devshell";

    # imports = [ devshellProfiles.rust ];
    # Tool Homepage: https://nix-community.github.io/nixago/
    # This is Standard's devshell integration.
    # It runs the startup hook when entering the shell.
    nixago = [
      (inputs.std-ext.presets.nixago.conform cell.configs.conform)
      (inputs.std-ext.presets.nixago.treefmt)
      (inputs.std-ext.presets.nixago.lefthook)
    ];

    packages = [ nixpkgs.d2 ];

    commands = [ ];
  };
}
