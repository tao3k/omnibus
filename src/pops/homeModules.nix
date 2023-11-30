# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  root,
  projectDir,
  POP,
  flops,
  inputs,
  lib,
  haumea,
  super,
}:
((flops.haumea.pops.default.setInit {
  src = projectDir + "/units/nixos/homeModules";
  type = "nixosModules";
  inputs = root.lib.loaderInputs;
}).addLoadExtender
  {load.inputs.inputs = super.flake.inputs;}
).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports = {
          exportModulesRecursive = lib.recursiveAttrValues self.layouts.default;
        };
      }
    ))
  ]
