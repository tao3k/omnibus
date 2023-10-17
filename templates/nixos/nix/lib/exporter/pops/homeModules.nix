(omnibus.pops.homeModules.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/nixos/homeModules";
    inputs = {
      inputs = inputs;
    };
  };
})
