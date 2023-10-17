(omnibus.pops.homeProfiles.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/nixos/homeProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
