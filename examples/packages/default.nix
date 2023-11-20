# [[file:../../docs/org/pops-packages.org::*Example][Example:1]]
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
# => out.exports { default = {...}, packages = {...}; }
# Example:1 ends here
