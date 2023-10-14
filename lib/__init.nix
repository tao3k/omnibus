{ inputs, omnibus }:
let
  inherit (inputs)
    flops
    haumea
    POP
    self
  ;
in
flops.lib.haumea.pops.default.setInit {
  src = ./.;
  loader = haumea.lib.loaders.scoped;
  inputs = {
    lib = flops.inputs.nixlib.lib // builtins;
    haumea = haumea.lib;
    POP = POP.lib;
    flops = flops.lib;
    inherit omnibus;
    inputs = inputs // {
      dmerge = flops.inputs.dmerge;
    };
  };
}
