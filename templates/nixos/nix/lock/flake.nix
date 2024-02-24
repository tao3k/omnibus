# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    srvos.url = "github:numtide/srvos";
    srvos.inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos.follows = "nixos-unstable";

    darwin-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";

    nixos-23-05.url = "github:nixos/nixpkgs/release-23.05";

    home-23-05.url = "github:nix-community/home-manager/release-23.05";
    home-23-05.inputs.nixpkgs.follows = "nixos-23-05";

    home.url = "github:nix-community/home-manager";
    home.inputs.nixpkgs.follows = "nixos";
  };

  inputs = {
    nix-filter = {
      url = "github:numtide/nix-filter";
    };
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
  };
  outputs = _: { };
}
