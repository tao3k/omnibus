# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  projectDir,
  POP,
  flops,
}:
(super.nixosModules.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/nixosProfiles";
    type = "nixosProfiles";
    transformer = [(_: _: _)];
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      selfP: _super: {
        exports = {
          omnibus = super.exportsOmnibusProfiles selfP.layouts.default;
        };
      }
    ))
  ]
