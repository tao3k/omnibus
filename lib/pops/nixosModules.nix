flops.haumea.pops.default.setInit {
  src = inputs.self.outPath + "/units/nixos/nixosModules";
  type = "nixosModules";
  inputs = root.loaderInputs;
}
