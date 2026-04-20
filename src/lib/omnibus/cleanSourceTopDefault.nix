# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ root, ... }:
src:
let
  inherit (root.pops.flake.inputs) nix-filter;
in
/**
  Filter out top-level `default.nix` files so tree loaders can consume the
  remaining source layout without re-importing the entrypoint file.
*/
nix-filter.lib.filter {
  root = src;
  exclude = [ "default.nix" ];
}
