# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    flops.url = "github:tao3k/flops";
  };

  outputs =
    { self, flops, ... }@inputs:
    let
      inherit (flops.popflow)
        haumea
        namaka
        ;
      omnibusPop = import ./src { inherit inputs; };
      src = omnibusPop.exports.default;
      supportedSystems = src.flakeOutputs.flake.inputs.nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      stdInputs = {
        inherit self namaka;
        omnibus = self;
        inherit (src.flakeOutputs.flake.inputs) nixpkgs;
      };
    in
    src.flakeOutputs
    // {
      eval = src.load {
        src = ./tests;
        inputs = src.flakeOutputs.flake.inputs.nixpkgs.lib.recursiveUpdate src.lib.omnibus.loaderInputs {
          inputs = stdInputs;
          system = "aarch64-darwin";
          debug = true;
        };
      };
      checks = supportedSystems (
        system:
        namaka.lib.load {
          src = ./tests;
          inputs = src.flakeOutputs.flake.inputs.nixpkgs.lib.recursiveUpdate src.lib.omnibus.loaderInputs {
            inputs = stdInputs;
            inherit system;
            debug = false;
          };
        }
      );
      pops = src.pops // {
        self = omnibusPop;
        nixosProfilesOmnibus = src.pops.nixosProfiles;
        darwinProfilesOmnibus = src.pops.darwinProfiles;
        homeProfilesOmnibus = src.pops.homeProfiles;

        nixosModules = src.pops.nixosModules.addLoadExtender {
          load.nixosModuleImporter = haumea.lib.loaders.default;
        };
        homeModules = src.pops.homeModules.addLoadExtender {
          load.nixosModuleImporter = haumea.lib.loaders.default;
        };
        darwinModules = src.pops.darwinModules.addLoadExtender {
          load.nixosModuleImporter = haumea.lib.loaders.default;
        };
        nixosProfiles = src.pops.nixosProfiles.addLoadExtender {
          load.type = "nixosProfiles";
          load.nixosModuleImporter = haumea.lib.loaders.default;
        };
        darwinProfiles = src.pops.darwinProfiles.addLoadExtender {
          load.type = "nixosProfiles";
          load.nixosModuleImporter = haumea.lib.loaders.default;
        };
        homeProfiles = src.pops.homeProfiles.addLoadExtender {
          load.type = "nixosProfiles";
          load.nixosModuleImporter = haumea.lib.loaders.default;
        };
      };

      inherit src;
      inherit (src) lib ops errors;
      call-flake = flops.popflow.call-flake;
    };

  nixConfig = {
    extra-substituters = [
      "https://tweag-topiary.cachix.org"
      "https://tweag-nickel.cachix.org"
      "https://organist.cachix.org"
      "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "tweag-topiary.cachix.org-1:8TKqya43LAfj4qNHnljLpuBnxAY/YwEBfzo3kzXxNY0="
      "tweag-nickel.cachix.org-1:GIthuiK4LRgnW64ALYEoioVUQBWs0jexyoYVeLDBwRA="
      "organist.cachix.org-1:GB9gOx3rbGl7YEh6DwOscD1+E/Gc5ZCnzqwObNH2Faw="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };
}
