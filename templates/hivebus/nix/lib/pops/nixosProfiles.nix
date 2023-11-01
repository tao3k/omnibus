(omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/units/nixos/nixosProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
