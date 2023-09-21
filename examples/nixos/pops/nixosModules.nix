(POS.loadNixOSModules.addLoadExtender { inputs = super.inputs.outputs // { }; })
.addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports.customModules.boot =
          self.outputsForTarget.dmerge
            {
              config.loader = {
                timeout = 10;
              };
            }
            [ "boot" ];
      }
    ))
  ]
