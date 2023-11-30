# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  projectDir,
  POP,
  flops,
  haumea,
}:
(super.homeModules.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/homeProfiles";
    type = "nixosProfiles";
    transformer = [(_: _: _)];
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      selfPop: _super: {
        exports = {
          omnibus = super.exportsOmnibusProfiles selfPop.layouts.default;
        };
      }
    ))
  ]
