(super.homeModules.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/homeProfiles";
    type = "nixosProfiles";
    transformer = [ (_: _: _) ];
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      _self: _super: {
        exports = {
          omnibus = super.exportsOmnibusProfiles self;
        };
      }
    ))
  ]
