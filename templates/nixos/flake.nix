{
  inputs = {
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    srvos.url = "github:numtide/srvos";
    srvos.inputs.nixpkgs.follows = "nixpkgs";

    omnibus.url = "github:gtrunsec/omnibus";
    haumea.follows = "omnibus/flops/haumea";
    flops.follows = "omnibus/flops";
  };

  # nixpkgs & home-manager
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

  outputs =
    { self, ... }@inputs:
    let
      eachSystem = inputs.nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      pops =
        (inputs.omnibus.pops.exporters.addLoadExtender {
          src = ./nix/lib;
          inputs = {
            self' = self;
            inherit inputs eachSystem;
            omnibus = inputs.omnibus.lib;
          };
        });
    in
    {
      inherit pops;
      lib = pops.outputs.default;
      inherit (self.lib.exporters)
        darwinConfigurations
        nixosConfigurations
        packages
        local
      ;
    };
}
