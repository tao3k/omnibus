flops.haumea.pops.default.setInit {
  src = inputs.self.outPath + "/units/nixos/homeModules";
  type = "nixosModules";
  inputs = root.loaderInputs;
}
