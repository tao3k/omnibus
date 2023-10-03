(omnibus.loadNixOSProfiles.addLoadExtender {
  inputs = super.inputs.outputs // {
    omnibus = {
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
              { selfModule' }:
              selfModule' (
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
              { selfModule' }:
              selfModule' (m: dmerge m { boot.__profiles__.systemd-boot.enable = true; });
            path = [
              "presets"
              "boot"
            ];
          }
        ];
      }
    ))
  ]
