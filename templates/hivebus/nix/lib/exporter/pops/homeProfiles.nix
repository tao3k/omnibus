(omnibus.pops.homeProfiles.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/units/nixos/homeProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
