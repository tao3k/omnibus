{
  inputs = {
    omnibus.url = "github:gtrunsec/omnibus";
    haumea.follows = "omnibus/flops/haumea";
    flops.follows = "omnibus/flops";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
  };

  outputs =
    { self, ... }@inputs:
    let
      eachSystem = inputs.flops.inputs.nixlib.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      pops = {
        nixosModules = inputs.omnibus.pops.nixosModules.addLoadExtender {
          load = {
            src = ./units/nixos/nixosModules;
          };
        };
        nixosProfiles = inputs.omnibus.pops.nixosProfiles.addLoadExtender {
          load = {
            src = ./units/nixos/nixosProfiles;
            inputs = {
              inherit inputs;
            };
          };
        };
        data = inputs.omnibus.pops.data.addLoadExtender {
          load = {
            src = ./data;
          };
        };
        allData = eachSystem (
          system:
          inputs.omnibus.pops.allData.addLoadExtender {
            load = {
              src = ./data;
              inputs = {
                inputs = {
                  nixpkgs = inputs.nixos-unstable.legacyPackages.${system};
                };
              };
            };
          }
        );
      };
      inherit (inputs.omnibus.lib) mapPopsLayouts;
    in
    mapPopsLayouts pops
    // {
      inherit pops;
      nixosConfigurations.simple = inputs.nixos-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ self.nixosProfiles.presets.boot ];
      };
    };
}
