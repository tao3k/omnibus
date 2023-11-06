flops.haumea.pops.default.setInit {
  src = projectDir + "/units/nixos/homeModules";
  type = "nixosModules";
  inputs = root.lib.loaderInputs;
}
