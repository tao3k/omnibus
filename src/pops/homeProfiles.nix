(super.homeModules.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/homeProfiles";
    type = "nixosProfiles";
    transformer = [ (_: _: _) ];
  };
})
