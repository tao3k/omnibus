(omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/nixos/darwinModules";
    inputs = {
      inputs = inputs;
    };
  };
})
