# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  projectRoot,
  POP,
  flops,
  haumea,
}:
(super.homeModules.addLoadExtender {
  load = {
    src = projectRoot + "/units/nixos/homeProfiles";
    type = "nixosProfilesOmnibus";
    transformer = [ (_: _: _) ];
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      _selfPop: _super: {
        exports = { };
      }
    ))
  ]
