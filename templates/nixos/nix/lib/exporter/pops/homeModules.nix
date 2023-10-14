(omnibus.pops.loadHomeModules.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/nixos/homeModules";
    inputs = {
      inputs = inputs;
    };
  };
})
