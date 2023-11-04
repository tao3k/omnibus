super.homeModules.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/units/nixos/homeProfiles";
    type = "nixosProfiles";
    transformer = [ (_: _: _) ];
  };
}
