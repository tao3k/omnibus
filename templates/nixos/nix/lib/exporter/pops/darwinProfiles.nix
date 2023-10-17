(omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/nixos/darwinProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
