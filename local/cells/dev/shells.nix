# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

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

    imports = [
      cell.pops.omnibus.devshellProfiles.exports.default.nickel
      std.std.devshellProfiles.default
    ];

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
      nixpkgs.poetry
      nixpkgs.tectonic

      nixpkgs.reuse
      nixpkgs.nixci
    ];

    commands = [ ];
  };

  std = lib.dev.mkShell {
    name = "std devshell";
    imports = [ std.std.devshellProfiles.default ];
    packages = [ nixpkgs.which ];
  };
}
