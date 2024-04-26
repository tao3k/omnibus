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
    host1 = rec {
      colmena = {
        nixpkgs = { };
      };
      system = "x86_64-linux";
      nixosConfiguration = {
        bee.pkgs = import nixpkgs { system = system; };
        bee.system = system;
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
    host2 = rec {
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
  hivePop =
    ((omnibus.pops.hive.setHosts hosts).addInputs {
      inherit (omnibus.flake.inputs) colmena nixpkgs;
    }).setNixosConfigurationsRenamer
      "asd";
  inherit (hivePop.exports) darwinConfigurations colmenaHive;
in
{
  # inherit hivePop;
}
