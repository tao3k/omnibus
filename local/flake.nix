{
  description = "Flops";

  inputs.std.follows = "std-ext/std";
  inputs.std-ext.url = "github:gtrunsec/std-ext";
  inputs.call-flake.url = "github:divnix/call-flake";
  inputs.namaka.follows = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    srvos.url = "github:numtide/srvos";
    srvos.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { std, ... }@inputs:
    let
      main = inputs.call-flake ../.;
    in
    std.growOn
      {
        inherit inputs;
        cellsFrom = ./cells;
        cellBlocks = with std.blockTypes; [
          # Development Environments
          (nixago "configs")
          (devshells "shells")
        ];
      }
      {
        devShells = std.harvest inputs.self [ [
          "repo"
          "shells"
        ] ];
      }
      {
        checks = inputs.namaka.lib.load {
          src = ../tests;
          inputs = main.lib // {
            inherit (main) inputs;
            lib = main.inputs.nixlib.lib // main.lib;
          };
        };
      };
}
