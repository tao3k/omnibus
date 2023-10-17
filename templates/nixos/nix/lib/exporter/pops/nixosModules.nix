(omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/nixos/nixosModules";
    inputs = {
      inputs = inputs;
    };
  };
})
