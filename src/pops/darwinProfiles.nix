# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  projectDir,
  flops,
  POP,
}:
(super.nixosProfiles.addLoadExtender {
  load = {
    type = "nixosProfilesOmnibus";
    src = projectDir + "/units/nixos/darwinProfiles";
  };
}).addExporters
  [(POP.extendPop flops.haumea.pops.exporter (selfPop: _super: {exports = {};}))]
