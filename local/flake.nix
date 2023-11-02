{
  nixConfig = {
    extra-substituters = [
      "https://tweag-topiary.cachix.org"
      "https://tweag-nickel.cachix.org"
    ];
    extra-trusted-public-keys = [
      "tweag-topiary.cachix.org-1:8TKqya43LAfj4qNHnljLpuBnxAY/YwEBfzo3kzXxNY0="
      "tweag-nickel.cachix.org-1:GIthuiK4LRgnW64ALYEoioVUQBWs0jexyoYVeLDBwRA="
    ];
  };

  description = "omnibus & std";

  inputs.std.follows = "std-ext/std";
  inputs.nixpkgs.follows = "std-ext/nixpkgs";

  inputs.std-ext.url = "github:gtrunsec/std-ext";
  inputs.std-ext.inputs.org-roam-book-template.follows = "";
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
        eval = inputs.haumea.lib.load {
          src = ../tests;
          inputs = inputs.nixpkgs.lib.recursiveUpdate omnibus.pops.lib.load.inputs {
            inherit inputs;
            trace = true;
          };
        };
        checks = inputs.namaka.lib.load {
          src = ../tests;
          inputs = inputs.nixpkgs.lib.recursiveUpdate omnibus.pops.lib.load.inputs {
            inherit inputs;
            trace = false;
          };
        };
      };
}
