{
  nixpkgs,
  lib,
  self,
  inputs,
}:
{
  colmena = {
    nixpkgs = { };
  };
  nixosConfiguration = {
    bee.pkgs = import nixpkgs { system = "x86_64-linux"; };
    bee.system = "x86_64-linux";
    imports = [ inputs.disko.nixosModules.default ];
  };
  asd = self.nixosConfiguration;
}
