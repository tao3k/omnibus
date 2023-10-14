(omnibus.pops.loadHomeProfiles.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/nixos/homeProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
