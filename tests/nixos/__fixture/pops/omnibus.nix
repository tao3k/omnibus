# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(omnibus.pops.self.addLoadExtender {
  load.inputs = {
    inputs = inputs;
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      _self: _super: { exports.customProfiles = { }; }
    ))
  ]
