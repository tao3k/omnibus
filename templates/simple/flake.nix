# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    omnibus.url = "github:gtrunsec/omnibus";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs =
    { self, ... }@inputs:
    let
      inherit (inputs.omnibus.inputs.flops.inputs.nixlib) lib;
      eachSystem = lib.genAttrs [
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
        homeProfiles = inputs.omnibus.pops.homeProfiles.addLoadExtender {
          load = {
            src = ./units/nixos/homeProfiles;
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
        omnibus = eachSystem (
          system:
          inputs.omnibus.pops.self.addLoadExtender {
            load.inputs = {
              inputs = {
                nixpkgs = inputs.nixos-unstable.legacyPackages.${system};
              };
            };
          }
        );
        allData = eachSystem (
          system:
          (pops.omnibus.${system}.outputs { }).pops.allData.addLoadExtender {
            load = {
              src = ./data;
            };
          }
        );
      };
      inherit (inputs.omnibus.lib.omnibus) mapPopsExports;
    in
    mapPopsExports pops
    // {
      inherit pops;
      nixosConfigurations.simple = inputs.nixos-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ self.nixosProfiles.presets.boot ];
      };
      homeConfigurations.simple = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixos-unstable.legacyPackages.x86_64-linux;
        modules = [ self.homeProfiles.presets.home-user1 ];
      };
    };
}
