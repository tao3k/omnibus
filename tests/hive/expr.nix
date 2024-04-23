{
  debug,
  lib,
  root,
  omnibus,
}:
let
  hosts = omnibus.load {
    src = ../../templates/nixos/units/nixos/hosts;
    inputs = {
      nixpkgs = omnibus.flake.inputs.nixpkgs;
      inputs = omnibus.flake.inputs;
    };
  };
  hive = omnibus.pops.hive.setHosts hosts;
in
{
  # darwin = hive.darwinConfiguraitons.darwin.config.system;
}
