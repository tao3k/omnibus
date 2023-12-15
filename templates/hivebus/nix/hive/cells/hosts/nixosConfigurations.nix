# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, cell }:
let
  inherit (inputs.nixpkgs) lib;
  layouts = lib.pipe inputs.hivebus.src.hosts [
    (lib.mapAttrs (_: v: v.layouts))
  ];
in
{
  example = layouts.nixos.hive;
}
