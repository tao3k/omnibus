(omnibus.pops.homeProfiles.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/homeProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
