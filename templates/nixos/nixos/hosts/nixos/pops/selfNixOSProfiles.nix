(super.nixosProfiles.addLoadExtender {
  src = ../__nixosProfiles;
  loader = haumea.loaders.scoped;
  type = "nixosProfiles";
  inputs = {
    local.data = self.lib.expoters.local.${root.nixos.layouts.system}.data;
    omnibus = rec {
      nixosModules = omnibus.loadNixOSModules.outputs.default;
      nixosProfiles =
        (omnibus.loadNixOSProfiles.addLoadExtender {
          inputs = {
            omnibus = {
              inherit nixosModules;
            };
          };
        }).outputs.default;
    };
  };
}).addExporters
  [ (POP.extendPop flops.haumea.pops.exporter (self: super: { })) ]
