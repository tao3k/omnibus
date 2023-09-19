{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
      loadModules = flops.lib.haumea.pops.default.setInit {
        src = ./nixos/nixosModules;
        type = "nixosModules";
      };
    in
    {
      inherit loadModules loadInputs;
      exporters = flops.lib.haumea.pops.default.setInit {
        loader = with haumea.lib; loaders.scoped;
        src = ./examples;
        inputs = {
          inherit loadModules loadInputs nixpkgs;
          lib = nixpkgs.lib // builtins;
          flops = flops.lib;
          haumea = flops.inputs.haumea.lib;
          POP = POP.lib;
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
