/* This file holds reproducible shells with commands in them.

   They conveniently also generate config files in their startup hook.
*/
{ inputs, cell }:
let
  inherit (inputs.std) lib;
in
{
  # Tool Homepage: https://numtide.github.io/devshell/
  default = lib.dev.mkShell {
    name = "flops devshell";

    # Tool Homepage: https://nix-community.github.io/nixago/
    # This is Standard's devshell integration.
    # It runs the startup hook when entering the shell.
    nixago = [
      (inputs.std-ext.presets.nixago.conform cell.configs.conform)
      (inputs.std-ext.presets.nixago.treefmt)
      (inputs.std-ext.presets.nixago.lefthook)
    ];

    commands = [ ];
  };
}
