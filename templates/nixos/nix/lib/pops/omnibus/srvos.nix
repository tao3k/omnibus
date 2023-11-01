(omnibus.pops.srvos.addLoadExtender { load = { }; }).addExporters [
  (POP.extendPop flops.haumea.pops.exporter (
    self: super: { exports.customProfiles = { }; }
  ))
]
