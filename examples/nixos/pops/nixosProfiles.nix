(loadNixOSProfiles.addLoadExtender {
  inputs = super.inputs.outputs // {
    POS = {
      nixosModules = super.nixosModules.outputsForTarget.nixosModules;
    };
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports.customProfiles = {
          nix =
            self.outputsForTarget.dmerge
              {
                nix.extraOptions = ''
                  allowed-uris = https://github.com/
                '';
              }
              [
                "presets"
                "nix"
              ];
          boot =
            (self.outputsForTarget.dmerge {
              # boot.__profiles__.systemd-initrd.enable = true;
              boot.__profiles__.systemd-boot.enable = true;
            })
              [
                "presets"
                "boot"
              ];
        };
      }
    ))
  ]
