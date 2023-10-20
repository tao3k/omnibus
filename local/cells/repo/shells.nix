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

    # imports = [ devshellProfiles.rust ];

    # Tool Homepage: https://nix-community.github.io/nixago/
    # This is Standard's devshell integration.
    # It runs the startup hook when entering the shell.
    nixago = [
      (std.lib.dev.mkNixago std.lib.cfg.conform cell.configs.conform.default
        cell.configs.conform'
      )
      (std.lib.dev.mkNixago std.lib.cfg.lefthook cell.configs.lefthook.default)
      (std.lib.dev.mkNixago std.lib.cfg.treefmt cell.configs.treefmt.default)
    ];

    packages = [ nixpkgs.d2 ];

    commands = [ ];
  };
}
