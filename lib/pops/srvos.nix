flops.haumea.pops.default.setInit {
  src = super.flake.inputs.srvos + "/nixos";
  type = "nixosProfiles";
  # reset the transformer to the default
  transformer = [ (_: _: _) ];
}
