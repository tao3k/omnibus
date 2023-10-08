(super.nixosProfiles.addLoadExtender {
  load = {
    src = ../__nixosProfiles;
    loader = haumea.loaders.scoped;
    type = "nixosProfiles";
    inputs = {
      local.data = self.lib.expoters.local.${root.nixos.layouts.system}.data;
      omnibus = rec {
        nixosModules = omnibus.pops.loadNixOSModules.layouts.default;
        nixosProfiles =
          (omnibus.pops.loadNixOSProfiles.addLoadExtender {
            load = {
              inputs = {
                omnibus = {
                  inherit nixosModules;
                };
              };
            };
          }).layouts.default;
      };
    };
  };
}).addExporters
  [ (POP.extendPop flops.haumea.pops.exporter (self: super: { })) ]
