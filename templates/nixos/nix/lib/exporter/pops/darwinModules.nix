(omnibus.pops.loadNixOSModules.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/nixos/darwinModules";
    inputs = {
      inputs = inputs;
    };
  };
})
