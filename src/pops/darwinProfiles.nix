# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  projectRoot,
  flops,
  POP,
}:
(super.nixosProfiles.addLoadExtender {
  load = {
    type = "nixosProfilesOmnibus";
    src = projectRoot + "/units/nixos/darwinProfiles";
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      _selfPop: _super: { exports = { }; }
    ))
  ]
