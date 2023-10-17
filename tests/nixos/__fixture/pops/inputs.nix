(omnibus.pops.flake.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    self: super:
    let
      selfInputs = omnibus.pops.flake.setInitInputs ../__lock;
      local = omnibus.pops.flake.setInitInputs (inputs.self.outPath + "/local");
    in
    {
      inputs = {
        std = local.outputs.std;
        nixpkgs = omnibus.pops.flake.inputs.nixpkgs.legacyPackages;
      } // selfInputs.inputs;
    }
  )
)).setSystem
  root.layouts.system
