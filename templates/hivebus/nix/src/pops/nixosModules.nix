(omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/nixosModules";
    inputs = {
      inputs = inputs;
    };
  };
})
