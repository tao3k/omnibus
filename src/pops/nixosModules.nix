# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  root,
  lib,
  projectDir,
  POP,
  flops,
}:
(flops.haumea.pops.default.setInit {
  src = projectDir + "/units/nixos/nixosModules";
  type = "nixosModules";
  inputs = root.lib.loaderInputs;
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
