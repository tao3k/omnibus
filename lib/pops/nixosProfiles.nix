super.nixosModules.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/units/nixos/nixosProfiles";
    type = "nixosProfiles";
    transformer = [ (_: _: _) ];
  };
}
