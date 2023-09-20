{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs = {
    flops.url = "github:gtrunsec/flops";
    POP.follows = "flops/POP";
    haumea.follows = "flops/haumea";
  };

  outputs =
    {
      self,
      nixpkgs,
      flops,
      POP,
      haumea,
      ...
    }@inputs:
    let
      eachSystem = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      loadInputs = flops.lib.flake.pops.default.setInitInputs ./local;
      loadNixOSModules = flops.lib.haumea.pops.default.setInit {
        src = ./nixos/nixosModules;
        type = "nixosModules";
      };
      loadHomeModules = flops.lib.haumea.pops.default.setInit {
        src = ./nixos/homeModules;
        type = "nixosModules";
      };
      loadHomeProfiles = loadHomeModules.addLoadExtender {
        src = ./nixos/homeProfiles;
        loader = haumea.lib.loaders.scoped;
        type = "nixosProfiles";
      };
      loadNixOSProfiles = flops.lib.haumea.pops.default.setInit {
        src = ./nixos/nixosProfiles;
        type = "nixosProfiles";
      };
      lib = flops.lib.haumea.pops.default.setInit {
        src = ./lib;
        loader = haumea.lib.loaders.scoped;
        inputs = {
          lib = nixpkgs.lib // builtins;
          home-manager = inputs.home-manager;
        };
      };
    in
    {
      inherit
        loadNixOSModules
        loadHomeModules
        loadHomeProfiles
        loadNixOSProfiles
        lib
      ;
      exporters = flops.lib.haumea.pops.default.setInit {
        loader = with haumea.lib; loaders.scoped;
        src = ./examples;
        inputs = {
          inherit
            loadNixOSModules
            loadHomeModules
            loadHomeProfiles
            loadNixOSProfiles
            loadInputs
            nixpkgs
          ;
          lib = nixpkgs.lib // builtins;
          flops = flops.lib;
          haumea = flops.inputs.haumea.lib;
          POP = POP.lib;
          selfLib = lib.outputsForTarget.default;
        };
      };
      nixosConfigurations =
        (self.exporters.addLoadExtender {
          src = ./nixos/nixosConfigurations;
          inputs = {
            exporters = self.exporters.outputsForTarget.default;
          };
        }).outputsForTarget.default;
    };
}
