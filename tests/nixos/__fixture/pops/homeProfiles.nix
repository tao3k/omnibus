(omnibus.pops.loadHomeProfiles.addLoadExtender {
  load.inputs = super.inputs.outputs // {
    omnibus = {
      homeModules = super.homeModules.layouts.nixosModules;
    };
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports.customProfiles = self.outputs [ {
          value =
            { selfModule' }:
            selfModule' (
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
