(omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/units/nixos/darwinProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
