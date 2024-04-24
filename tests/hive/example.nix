{
  debug,
  lib,
  root,
  omnibus,
  inputs,
}:
let
  inherit (inputs) nixpkgs;
  hosts = {
    hosts1 = rec {
      colmena = {
        nixpkgs = { };
      };
      system = "x86_64-linux";
      nixosConfiguration = {
        bee.pkgs = import nixpkgs { system = system; };
        bee.system = system;
        bee.colmena = inputs.colmena;
        imports = [ omnibus.flake.inputs.disko.nixosModules.default ];
      };
      asd = nixosConfiguration;
      colmenaConfiguration = {
        deployment = {
          allowLocalDeployment = true;
          targetHost = "127.0.0.1";
        };
        inherit (nixosConfiguration) bee imports;
      };
    };
    hosts2 = rec {
      colmena = {
        nixpkgs = { };
      };
      system = "aarch64-linux";
      darwinConfiguration = {
        bee.darwin = omnibus.flake.inputs.darwin;
        bee.system = system;
        bee.pkgs = import nixpkgs { system = system; };
      };
    };
  };
  hive = omnibus.pops.hive.setHosts hosts;
in
{
  darwin = hive.darwinConfiguraitons.darwin.config.system;
  inherit hive;
  hivePop = ((hive.setSystem "x86_64-linux").setNixosConfigurationsRenamer "asd");
}
