(omnibus.pops.flake.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    self: super:
    let
      selfInputs = omnibus.pops.flake.setInitInputs ../__lock;
      local = omnibus.pops.flake.setInitInputs (projectDir + "/local");
    in
    {
      inputs = {
        std = local.outputs.std;
      } // selfInputs.inputs;
    }
  )
)).setSystem
  root.layouts.system
