(POS.loadInputs.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    self: super: { inputs.nixpkgs = POS.loadInputs.outputs.nixpkgs.legacyPackages; }
  )
)).setSystem
  "x86_64-linux"
