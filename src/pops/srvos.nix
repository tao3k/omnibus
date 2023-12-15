# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  POP,
  flops,
  inputs,
  lib,
  haumea,
}:
(flops.haumea.pops.default.setInit {
  src = super.flake.inputs.srvos + "/nixos";
  type = "nixosProfiles";
  # reset the transformer to the default
  transformer = [ (_: _: _) ];
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports = {
          exportModulesRecursive = lib.recursiveAttrValues self.layouts.default;
        };
      }
    ))
  ]
