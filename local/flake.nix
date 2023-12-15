# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
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

  description = "omnibus & std";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    std = {
      url = "github:divnix/std";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.devshell.follows = "devshell";
      inputs.nixago.follows = "nixago";
    };

    nixago = {
      url = "github:nix-community/nixago";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixago-exts.follows = "";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  inputs.call-flake.url = "github:divnix/call-flake";
  inputs.namaka.url = "github:nix-community/namaka";
  inputs.haumea.follows = "namaka/haumea";

  outputs =
    { std, self, ... }@inputs:
    let
      omnibus = inputs.call-flake ../.;
    in
    std.growOn
      {
        inputs = inputs // {
          inherit omnibus;
        };
        cellsFrom = ./cells;
        cellBlocks = with std.blockTypes; [
          # Development Environments
          (nixago "configs")
          (devshells "shells")
          (functions "devshellProfiles")
          (functions "pops")
        ];
      }
      {
        devShells = std.harvest inputs.self [
          [
            "repo"
            "shells"
          ]
        ];
      }
      {
        examples = omnibus.load {
          src = ../examples;
          transformer = [ (_cursor: dir: if dir ? default then dir.default else dir) ];
          inputs = inputs.nixpkgs.lib.recursiveUpdate omnibus.lib.loaderInputs {
            inherit inputs;
            trace = true;
          };
        };
        eval = omnibus.load {
          src = ../tests;
          inputs = inputs.nixpkgs.lib.recursiveUpdate omnibus.lib.loaderInputs {
            inherit inputs;
            trace = true;
          };
        };
        checks = inputs.namaka.lib.load {
          src = ../tests;
          inputs = inputs.nixpkgs.lib.recursiveUpdate omnibus.lib.loaderInputs {
            inherit inputs;
            trace = false;
          };
        };
      };
}
