(omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/darwinModules";
    inputs = {
      inputs = inputs;
    };
  };
})
