# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

/* This file holds configuration data for repo dotfiles.

   Q: Why not just put the put the file there?

   A: (1) dotfile proliferation
      (2) have all the things in one place / fromat
      (3) potentially share / re-use configuration data - keeping it in sync
*/
{ inputs, cell }:
with inputs.std.inputs.dmerge;
let
  inherit (cell.pops.configs.exports.default) treefmt lefthook conform;
  cfg = {
    inherit (cell.pops.configs.exports.stdNixago) treefmt lefthook conform;
  };
in
{
  lefthook = {
    default = cfg.lefthook.default lefthook.just;
  };
  treefmt = {
    default = (cfg.treefmt.default treefmt.nvfetcher treefmt.nickel) {
      data.global = {
        excludes = append [ "./examples/jupyenv+quarto/quarto/*" ];
      };
    };
  };
  conform = rec {
    default = cfg.conform.default custom;
    custom = {
      data = {
        commit.conventional.scopes = append [
          "nixosModules"
          "nixosProfiles"
          "homeProfiles"
          "homeModules"
          "darwinModules"
          "darwinProfiles"
          "units"
          "units/*"
          ".*."
        ];
      };
    };
  };
}
