# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
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
(POP.extendPop
  (flops.haumea.pops.default.setInit {
    loader = with haumea; [ (matchers.nix loaders.default) ];
    inputs = root.lib.omnibus.loaderInputs;
  })
  (
    _: _: {
      __functor = self: selectors: self.addLoadExtender { load = selectors; };
    }
  )
).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports = {
          derivations = lib.attrsets.filterDerivations self.layouts.default;
        };
      }
    ))
  ]
