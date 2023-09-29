(POS.loadHomeProfiles.addLoadExtender {
  inputs = super.inputs.outputs // {
    POS = {
      homeModules = super.homeModules.outputs.nixosModules;
    };
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports.customProfiles = self.outputs.__extenders [ {
          value =
            { self' }:
            self' (
              m:
              dmerge m {
                wayland.windowManager.hyprland.__profiles__ = {
                  nvidia = true;
                };
              }
            );
          path = [
            "presets"
            "hyprland"
          ];
        } ];
      }
    ))
  ]
