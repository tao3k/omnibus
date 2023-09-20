(POS.loadHomeProfiles.addLoadExtender {
  inputs = super.inputs.outputs // {
    POS = {
      homeModules = super.homeModules.outputsForTarget.nixosModules;
    };
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports.customProfiles = {
          hyprland =
            self.outputsForTarget.dmerge
              {
                wayland.windowManager.hyprland.__profiles__ = {
                  nvidia = true;
                };
              }
              [
                "presets"
                "hyprland"
              ];
        };
      }
    ))
  ]