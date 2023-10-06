(omnibus.pops.loadNixOSModules.addLoadExtender {
  inputs = super.inputs.outputs // { };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports.customModules =
          with dmerge;
          self.outputs.__extenders [ ({
            value =
              { selfModule' }:
              selfModule' (
                m:
                dmerge m {
                  config.boot.contents = update [ 0 ] [ {
                    content = {
                      loader.timeout.content = 10;
                      # loader.efi.canTouchEfiVariables = false;
                    };
                  } ];
                }
              );
            path = [ "boot" ];
          }) ];
      }
    ))
  ]
