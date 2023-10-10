{ inputs, omnibus }:
let
  inherit (inputs)
    flops
    haumea
    dmerge
    POP
    self
  ;
in
flops.lib.haumea.pops.default.setInit {
  src = ./.;
  loader = haumea.lib.loaders.scoped;
  inputs = {
    lib = flops.inputs.nixlib.lib // builtins;
    self' = self;
    haumea = haumea.lib;
    POP = POP.lib;
    flops = flops.lib;
    inherit omnibus;
    inputs = {
      dmerge = inputs.flops.inputs.dmerge;
      home-manager = omnibus.pops.loadInputs.outputs.home-manager;
    };
  };
}
