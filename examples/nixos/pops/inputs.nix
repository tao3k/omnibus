(POS.loadInputs.addInputsExtender (
  POP.extendPop flops.flake.pops.inputsExtender (
    self: super: { inputs.nixpkgs = nixpkgs.legacyPackages; }
  )
)).setSystem
  "x86_64-linux"
