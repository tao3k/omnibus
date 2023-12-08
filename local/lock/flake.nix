# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos.follows = "nixpkgs";
    nixos-23_05.url = "github:nixos/nixpkgs/release-23.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    srvos.url = "github:numtide/srvos";
    srvos.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    audioNix.url = "github:polygon/audio.nix";
    audioNix.inputs.nixpkgs.follows = "nixpkgs";

    nix-filter.url = "github:numtide/nix-filter";
  };

  inputs = {
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    makesSrc.url = "github:fluidattacks/makes";
    makesSrc.flake = false;

    nur.url = "github:nix-community/NUR";

    topiary.url = "github:tweag/topiary";

    std.url = "github:divnix/std";

    microvm.url = "github:astro/microvm.nix";
  };

  inputs = {
    organist.url = "github:nickel-lang/organist";

    nickel.url = "github:tweag/nickel";
    # nickel.follows = "organist/nickel";
    nickel.inputs.topiary.follows = "topiary";

    nil.url = "github:oxalica/nil";
    nil.inputs.nixpkgs.follows = "nixpkgs";

    typst.url = "github:typst/typst";
    typst.inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";

    snapshotter.url = "github:pdtpartners/nix-snapshotter";
    snapshotter.inputs.nixpkgs.follows = "nixpkgs";

    ragenix.url = "github:yaxitech/ragenix";
    ragenix.inputs.nixpkgs.follows = "nixpkgs";
    ragenix.inputs.agenix.follows = "agenix";

    agenix.url = "github:ryantm/agenix";
    # agenix.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix"; # sops-template
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixfmt.url = "github:serokell/nixfmt/?ref=refs/pull/118/head";
    # nixfmt.inputs.flake-compat.follows = "nixpkgs";
    nixfmt.inputs.flake-compat.follows = "";

    bird-nix-lib.url = "github:spikespaz/bird-nix-lib";
    bird-nix-lib.flake = false;
  };

  inputs = {
    climodSrc.url = "github:nixosbrasil/climod";
    climodSrc.flake = false;

    nix-fast-build.url = "github:Mic92/nix-fast-build";
    nix-fast-build.inputs.nixpkgs.follows = "nixpkgs";
    nix-fast-build.inputs.treefmt-nix.follows = "";

    navi-tldr-pages.url = "github:denisidoro/navi-tldr-pages";
    navi-tldr-pages.flake = false;

    catppuccin-foliate.url = "github:catppuccin/foliate";
    catppuccin-foliate.flake = false;
  };
  outputs = _: {};
}
