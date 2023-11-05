super.nixosProfiles.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/darwinProfiles";
  };
}
