# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  flops,
  haumea,
  root,
  POP,
  lib,
}:
let
  inherit (flops) recursiveMerge';
in
load:
(flops.haumea.pops.default.setInit (
  recursiveMerge' [
    {
      loader = with haumea; [ (matchers.nix loaders.default) ];
      inputs = root.lib.loaderInputs;
    }
    load
  ]
)).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports = {
          composeOverlays = lib.composeManyExtensions (
            lib.recursiveAttrValues self.layouts.default
          );
        };
      }
    ))
  ]
