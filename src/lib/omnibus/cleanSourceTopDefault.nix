# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib, root }:
src:
let
  inherit (root.pops.flake.inputs) nix-filter;
in
nix-filter.lib.filter {
  root = src;
  exclude = [ "default.nix" ];
}
