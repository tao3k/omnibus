(omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/units/nixos/darwinModules";
    inputs = {
      inputs = inputs;
    };
  };
})
