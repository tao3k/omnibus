(omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/units/nixos/nixosModules";
    inputs = {
      inputs = inputs;
    };
  };
})
