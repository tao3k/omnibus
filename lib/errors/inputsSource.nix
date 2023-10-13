{ lib }:
list:
lib.filter (pair: lib.elem pair.name list) [
  {
    name = "nixpkgs";
    url = "github:nixpkgs/nixpkgs-unstable";
  }
  {
    name = "makes";
    url = "github:fluidattacks/makes";
  }
  {
    name = "home-manager";
    url = "github:github:nix-community/home-manager";
  }
  {
    name = "microvm";
    url = "github:astro/microvm.nix";
  }
  {
    name = "topiary";
    url = "github:github:tweag/topiary";
  }
  {
    name = "nur";
    url = "github:nix-community/NUR";
  }
]
