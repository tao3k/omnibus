(omnibus.pops.srvos.addLoadExtender {
  load.inputs = super.inputs.outputs // { };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: { exports.customProfiles = { }; }
    ))
  ]
