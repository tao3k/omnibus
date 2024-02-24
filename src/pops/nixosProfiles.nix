# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  projectRoot,
  POP,
  flops,
}:
(super.nixosModules.addLoadExtender {
  load = {
    src = projectRoot + "/units/nixos/nixosProfiles";
    type = "nixosProfilesOmnibus";
    transformer = [ (_: _: _) ];
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (_selfP: _super: { exports = { }; }))
  ]
