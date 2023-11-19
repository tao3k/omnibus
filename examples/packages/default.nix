{
  omnibus,
  inputs,
  self,
}:
omnibus.pops.packages {
  src = ./__fixture;
  inputs = {
    nixpkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  };
}
