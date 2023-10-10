(omnibus.pops.loadInputs.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    self: super:
    let
      selfInputs = omnibus.pops.loadInputs.setInitInputs ../__lock;
      local = omnibus.pops.loadInputs.setInitInputs (inputs.self.outPath + "/local");
    in
    {
      inputs = {
        std = local.outputs.std;
        nixpkgs = omnibus.pops.loadInputs.outputs.nixpkgs.legacyPackages;
      } // selfInputs.outputs;
    }
  )
)).setSystem
  root.layouts.system
