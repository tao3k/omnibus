(omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/nixosProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
