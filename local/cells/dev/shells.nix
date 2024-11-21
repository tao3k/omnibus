# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

/*
  This file holds reproducible shells with commands in them.

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

    imports = [
      cell.pops.omnibus.devshellProfiles.exports.default.nickel
    ];

    # Tool Homepage: https://nix-community.github.io/nixago/
    # This is Standard's devshell integration.
    # It runs the startup hook when entering the shell.
    nixago = [
      cell.configs.conform.default
      cell.configs.lefthook.default
      cell.configs.treefmt.default
    ];

    devshell.startup.pog.text = '''';

    packages = [
      nixpkgs.d2
      nixpkgs.statix
      nixpkgs.deadnix
      nixpkgs.tree
      nixpkgs.poetry
      nixpkgs.tectonic

      nixpkgs.reuse
      nixpkgs.nixci
      cell.scripts.pog
    ];

    commands = [
      {
        name = "std";
        help = std.packages.std.meta.description;
        command = ''
          (cd $PRJ_ROOT/local && ${std.packages.std}/bin/std "$@")
        '';
      }
    ];
  };

  std = lib.dev.mkShell {
    name = "std devshell";
    imports = [ std.std.devshellProfiles.default ];
    packages = [ nixpkgs.which ];
  };
}
