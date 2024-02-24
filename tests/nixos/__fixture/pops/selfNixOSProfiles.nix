# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(super.nixosProfiles.addLoadExtender {
  load = {
    src = ../__nixosProfiles;
    loader = haumea.loaders.scoped;
    type = "nixosProfiles";
    inputs = {
      omnibus = {
        nixosProfiles = super.nixosProfiles.outputs.nixosProfiles;
        data = super.data.exports.default;
      };
    };
  };
}).addExporters
  [ (POP.extendPop flops.haumea.pops.exporter (_self: _super: { })) ]
