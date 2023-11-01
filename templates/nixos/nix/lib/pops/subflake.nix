(omnibus.pops.flake.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    self: super:
    let
      subflake = omnibus.pops.flake.setInitInputs ../../lock;
    in
    {
      inputs = subflake.inputs;
    }
  )
))
