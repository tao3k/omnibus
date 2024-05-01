# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  flops,
  haumea,
  super,
  POP,
  flops,
}:
super.load.addExporters [
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
