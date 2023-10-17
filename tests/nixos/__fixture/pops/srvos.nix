(omnibus.pops.srvos.addLoadExtender { load.inputs = { }; }).addExporters [
  (POP.extendPop flops.haumea.pops.exporter (
    self: super: { exports.customProfiles = { }; }
  ))
]
