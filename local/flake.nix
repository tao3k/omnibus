{
  description = "Flops";

  inputs.std.follows = "std-ext/std";
  inputs.nixpkgs.follows = "std-ext/nixpkgs";
  inputs.std-ext.url = "github:gtrunsec/std-ext";
  inputs.call-flake.url = "github:divnix/call-flake";
  inputs.namaka.follows = "";

  outputs =
    { std, ... }@inputs:
    let
      POS = inputs.call-flake ../.;
    in
    std.growOn
      {
        inputs = inputs // {
          inherit POS;
        };
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
          inputs = POS.inputs // {
            POS = POS;
            lib = inputs.nixpkgs.lib // POS.lib;
          };
        };
      };
}
