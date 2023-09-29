(super.nixosProfiles.addLoadExtender {
  src = ../__nixosProfiles;
  loader = haumea.loaders.scoped;
  type = "nixosProfiles";
  inputs = {
    POS = {
      nixosProfiles = super.nixosProfiles.outputs.nixosProfiles;
      data = super.data.outputs.default;
    };
  };
}).addExporters
  [ (POP.extendPop flops.haumea.pops.exporter (self: super: { })) ]
