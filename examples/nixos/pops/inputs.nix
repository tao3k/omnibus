(omnibus.loadInputs.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    self: super:
    let
      selfInputs = omnibus.loadInputs.setInitInputs ../__lock;
      local = omnibus.loadInputs.setInitInputs ../../../local;
    in
    {
      inputs = {
        std = local.outputs.std;
        nixpkgs = omnibus.loadInputs.outputs.nixpkgs.legacyPackages;
      } // selfInputs.outputs;
    }
  )
)).setSystem
  "x86_64-linux"
