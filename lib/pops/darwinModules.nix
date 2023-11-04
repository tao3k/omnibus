super.nixosModules.addLoadExtender {
  load.src = inputs.self.outPath + "/units/nixos/darwinModules";
}
