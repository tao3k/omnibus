(self'.lib.nixos.loadNixOSProfiles.addLoadExtender { inputs = { }; })
.addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports.customProfiles = self.outputs.__extenders [ {
          value =
            { selfModule' }:
            selfModule' (
              m: dmerge m { boot.__profiles__.test = "nixosProfiles.test with Dmerge"; }
            );
          path = [
            "presets"
            "boot"
          ];
        } ];
      }
    ))
  ]
