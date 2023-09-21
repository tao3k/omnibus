(POS.loadInputs.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    self: super:
    let
      selfInputs = POS.loadInputs.setInitInputs ../__lock;
    in
    {
      inputs = {
        nixpkgs = POS.loadInputs.outputs.nixpkgs.legacyPackages;
      } // selfInputs.outputs;
    }
  )
)).setSystem
  "x86_64-linux"
