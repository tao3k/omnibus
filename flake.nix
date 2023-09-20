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
          lib = flops.inputs.nixlib.lib // builtins;
          home-manager = loadInputs.outputs.home-manager;
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
          lib = flops.inputs.nixlib.lib // builtins;
          flops = flops.lib;
          haumea = flops.inputs.haumea.lib;
          dmerge = flops.inputs.dmerge;
          POP = POP.lib;
          POS = {
            lib = lib.outputsForTarget.default;
            inherit
              loadNixOSModules
              loadHomeModules
              loadHomeProfiles
              loadNixOSProfiles
              loadInputs
            ;
          };
        };
      };
      nixosConfigurations =
        (self.exporters.addLoadExtender {
          src = ./nixos/nixosConfigurations;
          inputs = {
            nixpkgs = loadInputs.outputs.nixpkgs;
            exporters = self.exporters.outputsForTarget.default;
          };
        }).outputsForTarget.default;
    };
}
