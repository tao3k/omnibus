{
  inputs = {
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixlib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flops.url = "github:gtrunsec/flops";
  };

  outputs =
    {
      self,
      nixlib,
      nixpkgs,
      flops,
      ...
    }@inputs:
    let
      l = nixlib.lib;
      loadModules = flops.lib.haumea.pops.default.setInit {
        src = ./nixosModules;
        type = "nixosModules";
      };
    in
    {
      inherit loadModules;
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          loadModules.outputsForTarget.default.boot
          { config.boot.__profiles__.systemd-boot.enable = true; }
        ];
      };
    };
}
