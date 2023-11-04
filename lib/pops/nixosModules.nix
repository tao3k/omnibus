flops.haumea.pops.default.setInit {
  src = inputs.self.outPath + "/units/nixos/nixosModules";
  type = "nixosModules";
  inputs = omnibus.pops.lib.load.inputs;
}
