(POS.loadHomeModules.addLoadExtender {
  inputs = {
    __misc__ = {
      inherit (super.inputs.outputs) catppuccin-bat;
    };
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports.customModules.git =
          self.outputsForTarget.dmerge
            {
              enable = false;
              customList = with dmerge; append [ "1" ];
              imports = with dmerge; append [ ];
            }
            [
              "services"
              "openssh"
            ];
      }
    ))
  ]
