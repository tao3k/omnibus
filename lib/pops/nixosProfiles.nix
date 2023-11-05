super.nixosModules.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/nixosProfiles";
    type = "nixosProfiles";
    transformer = [ (_: _: _) ];
  };
}
