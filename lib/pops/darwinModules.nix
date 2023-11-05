super.nixosModules.addLoadExtender {
  load.src = projectDir + "/units/nixos/darwinModules";
}
