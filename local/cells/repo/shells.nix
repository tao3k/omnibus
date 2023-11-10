/* This file holds reproducible shells with commands in them.

   They conveniently also generate config files in their startup hook.
*/
{ inputs, cell }:
let
  inherit (inputs.std) lib;
  inherit (inputs) nixpkgs std;
in
{
  # Tool Homepage: https://numtide.github.io/devshell/
  default = lib.dev.mkShell {
    name = "omnibus devshell";

    imports = [ cell.pops.devshellProfiles.exports.default.nickel ];

    # Tool Homepage: https://nix-community.github.io/nixago/
    # This is Standard's devshell integration.
    # It runs the startup hook when entering the shell.
    nixago = [
      cell.configs.conform.default
      cell.configs.lefthook.default
      cell.configs.treefmt.default
    ];

    packages = [
      nixpkgs.d2
      nixpkgs.statix
      nixpkgs.deadnix
      nixpkgs.tree
    ];

    commands = [ ];
  };
}
