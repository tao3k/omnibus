{
  description = "omnibus";

  inputs.std.follows = "std-ext/std";
  inputs.nixpkgs.follows = "std-ext/nixpkgs";
  inputs.std-ext.url = "github:gtrunsec/std-ext";
  inputs.std-ext.inputs.org-roam-book-template.follows = "";
  inputs.call-flake.url = "github:divnix/call-flake";
  inputs.namaka.follows = "";

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
          inputs = omnibus.inputs // {
            omnibus = omnibus;
            lib = inputs.nixpkgs.lib // omnibus.lib;
            inputs' = inputs;
          };
        };
      };
}
