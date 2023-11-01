(omnibus.pops.homeModules.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/units/nixos/homeModules";
    inputs = {
      inputs = inputs;
    };
  };
})
