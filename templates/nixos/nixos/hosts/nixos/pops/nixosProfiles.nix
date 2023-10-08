(self'.lib.nixos.loadNixOSProfiles.addLoadExtender { load.inputs = { }; })
.addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports.customProfiles = self.outputs [ {
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
