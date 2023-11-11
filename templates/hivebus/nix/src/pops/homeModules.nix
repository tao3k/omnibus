(omnibus.pops.homeModules.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/homeModules";
    inputs = {
      inputs = inputs;
    };
  };
})
