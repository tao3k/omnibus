{ inputs, omnibus }:
let
  inherit (inputs) flops self;
  inherit (flops.inputs)
    POP
    yants
    haumea
    nixlib
  ;
in
flops.lib.haumea.pops.default.setInit {
  src = ./.;
  loader = haumea.lib.loaders.scoped;
  inputs = {
    lib = nixlib.lib // builtins;
    haumea = haumea.lib;
    POP = POP.lib;
    flops = flops.lib;
    inherit omnibus yants;
    inputs = {
      inherit (inputs) self;
      dmerge = flops.inputs.dmerge;
    };
  };
}
