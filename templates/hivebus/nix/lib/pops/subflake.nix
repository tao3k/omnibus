(omnibus.pops.flake.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    _self: _super:
    let
      subflake = omnibus.pops.flake.setInitInputs ../../lock;
    in
    {
      inputs = subflake.inputs;
    }
  )
))
