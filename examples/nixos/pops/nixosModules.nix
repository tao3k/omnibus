(loadNixOSModules.addLoadExtender { inputs = super.inputs__.outputs // { }; })
.addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: { exports.customModules = { }; }
    ))
  ]
