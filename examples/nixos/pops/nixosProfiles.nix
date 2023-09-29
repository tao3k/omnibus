(POS.loadNixOSProfiles.addLoadExtender {
  inputs = super.inputs.outputs // {
    POS = {
      nixosModules = super.nixosModules.outputs.nixosModules;
    };
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports.customProfiles = self.outputs.__extenders [
          {
            value =
              { self' }:
              self' (
                m:
                dmerge m {
                  nix.extraOptions = ''
                    allowed-uris = https://github.com/
                  '';
                }
              );
            path = [
              "presets"
              "nix"
            ];
          }
          {
            # boot.__profiles__.systemd-initrd.enable = true;
            value =
              { self' }:
              self' (m: dmerge m { boot.__profiles__.systemd-boot.enable = true; });
            path = [
              "presets"
              "boot"
            ];
          }
        ];
      }
    ))
  ]
