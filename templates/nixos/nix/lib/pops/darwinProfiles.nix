(omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/darwinProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
