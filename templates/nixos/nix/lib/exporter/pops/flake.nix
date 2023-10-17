(omnibus.pops.flake.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    self: super:
    let
      selfInputs = omnibus.pops.flake.setInitInputs ../../__lock;
    in
    {
      inputs = {
        nixpkgs = inputs.nixpkgs.legacyPackages;
      } // selfInputs.inputs;
    }
  )
))
