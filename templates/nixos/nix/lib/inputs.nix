(omnibus.pops.loadInputs.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    self: super:
    let
      selfInputs = omnibus.pops.loadInputs.setInitInputs ./__lock;
    in
    {
      inputs = {
        inputs.nixpkgs = inputs.nixpkgs.legacyPackages;
      } // selfInputs.outputs;
    }
  )
))
