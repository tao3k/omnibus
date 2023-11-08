(omnibus.pops.srvos.addLoadExtender { load.inputs = { }; }).addExporters [
  (POP.extendPop flops.haumea.pops.exporter (
    _self: _super: { exports.customProfiles = { }; }
  ))
]
