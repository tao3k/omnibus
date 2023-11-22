# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
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

    paisano = {
      url = "github:paisano-nix/core";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hive = {
      url = "github:divnix/hive";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.paisano.follows = "paisano";
      inputs.std.follows = "std";
      inputs.colmena.follows = "colmena";
    };

    colmena = {
      url = "github:zhaofengli/colmena";
      # keep the cache
      # inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "";
    };
  };

  inputs = {
    call-flake.url = "github:divnix/call-flake";
  };

  outputs =
    {
      self,
      std,
      hive,
      call-flake,
      ...
    }@inputs:
    std.growOn
      {
        inputs = inputs // {
          hivebus = call-flake ../..;
        };
        systems = [
          "aarch64-darwin"
          "aarch64-linux"
          "x86_64-darwin"
          "x86_64-linux"
        ];

        cellsFrom = ./cells;

        cellBlocks =
          with std.blockTypes;
          with hive.blockTypes; [
            # configurations can be deployed
            colmenaConfigurations
            homeConfigurations
            nixosConfigurations
            diskoConfigurations
            darwinConfigurations

            (arion "arionConfigurations")
            (microvms "microvms")

            # devshells can be entered
            (devshells "shells")

            # jobs can be run
            (runnables "entrypoints")
            (runnables "scripts")
            (functions "tasks")
            (functions "apps")

            # lib holds shared knowledge made code
            (functions "lib")
            (data "data")
            (functions "configs")
            (installables "packages" { ci.build = true; })
            (functions "overlays")

            # nixago part
            (nixago "nixago")

            # containers collection
            (containers "containers" { ci.publish = true; })
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
      # soil - the first (and only) layer implements adapters for tooling
      {
        # tools
        colmenaHive = hive.collect self "colmenaConfigurations";
        nixosConfigurations = hive.collect self "nixosConfigurations";
        homeConfigurations = hive.collect self "homeConfigurations";
        darwinConfigurations = hive.collect self "darwinConfigurations";
        diskoConfigurations = hive.collect self "diskoConfigurations";
      };
  # --- Flake Local Nix Configuration ----------------------------
  nixConfig = {
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://colmena.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://cachix.org/api/v1/cache/emacs"
      "https://microvm.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
      "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
    ];
  };
}
