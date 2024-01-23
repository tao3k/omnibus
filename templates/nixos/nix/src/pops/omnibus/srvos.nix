# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(omnibus.pops.srvos.addLoadExtender { load = { }; }).addExporters [
  (POP.extendPop flops.haumea.pops.exporter (
    _self: _super: { exports.customProfiles = { }; }
  ))
]
