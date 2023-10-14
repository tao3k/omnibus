(omnibus.pops.loadNixOSProfiles.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/nixos/nixosProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
