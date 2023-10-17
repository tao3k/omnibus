(omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/nixos/nixosProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
