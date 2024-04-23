{
  inputs,
  self,
  nixpkgs,
}:
{
  colmena = {
    nixpkgs = { };
  };
  system = "aarch64-darwin";

  darwinConfiguration = {
    bee.darwin = inputs.darwin;
    bee.system = self.system;
    bee.pkgs = import nixpkgs { system = self.system; };
  };
}
