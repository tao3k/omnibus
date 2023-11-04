{ inputs, eachSystem }:
(inputs.omnibus.pops.load {
  src = ./.;
  inputs = {
    inherit inputs eachSystem;
    projectDir = ../..;
  };
})
