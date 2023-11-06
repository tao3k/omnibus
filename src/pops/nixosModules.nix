flops.haumea.pops.default.setInit {
  src = projectDir + "/units/nixos/nixosModules";
  type = "nixosModules";
  inputs = root.lib.loaderInputs;
}
