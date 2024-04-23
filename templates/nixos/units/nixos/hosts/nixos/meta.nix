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
  system = "x86_64-linux";
  nixosConfiguration = {
    bee.pkgs = import nixpkgs { system = self.system; };
    bee.system = self.system;
    bee.colmena = inputs.colmena;
    imports = [ inputs.disko.nixosModules.default ];
  };
  asd = self.nixosConfiguration;
  colmenaConfiguration = {
    deployment = {
      allowLocalDeployment = true;
      targetHost = "127.0.0.1";
    };
    inherit (self.nixosConfiguration) bee imports;
  };
}
