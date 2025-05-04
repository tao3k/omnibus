# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
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
  };
  inputs.namaka.url = "github:nix-community/namaka";

  outputs =
    { self, ... }@inputs:
    let
      omnibus = import ../.;
      inherit (omnibus.flake.inputs) std;
      omnibusStd =
        (omnibus.pops.std {
          inputs.inputs = {
            inherit std;
          };
        }).exports.default;
    in
    omnibusStd.mkDefaultStd
      {
        inputs = inputs // {
          inherit omnibus;
        };
        cellsFrom = ./cells;
      }
      {
        devShells = std.harvest inputs.self [
          [
            "dev"
            "shells"
          ]
        ];
      }
      {
        eval = omnibus.load {
          src = ../tests;
          inputs = inputs.nixpkgs.lib.recursiveUpdate omnibus.lib.omnibus.loaderInputs {
            inherit inputs;
            debug = true;
          };
        };
        checks = inputs.namaka.lib.load {
          src = ../tests;
          inputs = inputs.nixpkgs.lib.recursiveUpdate omnibus.lib.omnibus.loaderInputs {
            inherit inputs;
            debug = false;
          };
        };
      };
}
