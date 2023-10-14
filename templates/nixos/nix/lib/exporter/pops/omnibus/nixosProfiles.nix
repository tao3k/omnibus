(omnibus.pops.loadNixOSProfiles.addLoadExtender { load = { }; }).addExporters [
  (POP.extendPop flops.haumea.pops.exporter (
    self: super: {
      exports.customModules = self.outputs [ {
        value = {
          enable = false;
          customList = with inputs.dmerge; append [ "1" ];
          imports = with inputs.dmerge; append [ ];
        };
        path = [
          "services"
          "openssh"
        ];
      } ];
    }
  ))
]
