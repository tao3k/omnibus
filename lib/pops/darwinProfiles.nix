super.nixosProfiles.addLoadExtender {
  load = {
    src = inputs.self.outPath + "/units/nixos/darwinProfiles";
  };
}
