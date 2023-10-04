(self'.inputs.loadInputs.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    self: super:
    let
      selfInputs = omnibus.loadInputs.setInitInputs ../__lock;
    in
    {
      inputs = {
        std = local.outputs.std;
        nixpkgs = omnibus.loadInputs.outputs.nixpkgs.legacyPackages;
      } // selfInputs.outputs;
    }
  )
)).setSystem
  root.nixos.layouts.system
