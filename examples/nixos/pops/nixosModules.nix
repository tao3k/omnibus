(POS.loadNixOSModules.addLoadExtender { inputs = super.inputs.outputs // { }; })
.addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports.customModules.boot =
          with dmerge;
          self.outputsForTarget.dmerge
            {
              config.boot.contents = update [ 0 ] [ {
                content = {
                  loader.timeout.content = 10;
                  # loader.efi.canTouchEfiVariables = false;
                };
              } ];
            }
            [ "boot" ];
      }
    ))
  ]
