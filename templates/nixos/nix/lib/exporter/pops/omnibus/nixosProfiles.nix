(omnibus.pops.loadNixOSProfiles.addLoadExtender { }).addExporters [
  (POP.extendPop flops.haumea.pops.exporter (
    self: super: {
      exports.customModules = self.outputs [ {
        value = {
          enable = false;
          customList = with dmerge; append [ "1" ];
          imports = with dmerge; append [ ];
        };
        path = [
          "services"
          "openssh"
        ];
      } ];
    }
  ))
]
