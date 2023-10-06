{
  inputs = {
    flops.url = "github:gtrunsec/flops";
    POP.follows = "flops/POP";
    haumea.follows = "flops/haumea";
  };

  outputs =
    {
      self,
      flops,
      POP,
      haumea,
      ...
    }@inputs:
    let
      omnibus = {
        inherit (self) pops;
        inherit lib;
      };
      lib = flops.lib.haumea.pops.default.setInit {
        src = ./lib;
        loader = haumea.lib.loaders.scoped;
        inputs = {
          lib = flops.inputs.nixlib.lib // builtins;
          self' = self;
          home-manager = omnibus.pops.loadInputs.outputs.home-manager;
          haumea = haumea.lib;
          dmerge = inputs.flops.inputs.dmerge;
          POP = POP.lib;
          flops = flops.lib;
          inherit omnibus;
        };
      };

      nixosConfigurations =
        (self.pops.exporters.addLoadExtender {
          src = ./nixos/nixosConfigurations;
          inputs = {
            nixpkgs = omnibus.pops.loadInputs.outputs.nixpkgs;
            exporters = self.pops.exporters.outputs.default;
          };
        }).outputs.default;
    in
    {
      inherit (lib.outputs.default.exporters) pops;
      inherit nixosConfigurations lib;

      templates.default = {
        path = ./templates/nixos;
        description = "Omnibus & nixos";
        welcomeText = ''
          You have created an Omnibus.nixos template!
        '';
      };
    };
}
