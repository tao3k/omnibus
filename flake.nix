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
      dotfiles = ./dotfiles;
      loadInputs = flops.lib.flake.pops.default.setInitInputs ./local/lock;
      loadData = flops.lib.haumea.pops.default.setInit {
        src = ./examples/__data;
        loader = with inputs.flops.inputs.haumea.lib; [
          # without the nixpkgs requirement, only the nixpkgs.lib
          # (matchers.regex "^(.+)\\.(yaml|yml)$" (
          #   _: _: path:
          #   loadInputs.outputs.std."x86_64-linux".lib.ops.readYAML path
          # ))
          matchers.json
          matchers.toml
        ];
      };
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
        inputs = {
          inherit dotfiles;
        };
      };
      loadNixOSProfiles = flops.lib.haumea.pops.default.setInit {
        src = ./nixos/nixosProfiles;
        type = "nixosProfiles";
      };
      srvos = flops.lib.haumea.pops.default.setInit {
        src = builtins.unsafeDiscardStringContext (loadInputs.outputs.srvos + "/nixos");
        type = "nixosProfiles";
        # reset the transformer to the default
        transformer = [ (_: _: _) ];
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
        loadInputs
        srvos
        loadData
        lib
        dotfiles
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
              loadData
              srvos
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

      evalModules = {
        devshell = rec {
          loadModules = flops.lib.haumea.pops.default.setInit {
            src = ./evalModules/devshell/modules;
            type = "nixosModules";
          };
          loadProfiles = flops.lib.haumea.pops.default.setInit {
            src = ./evalModules/devshell/profiles;
            type = "nixosProfiles";
            inputs = {
              POS.devshellModules = loadModules.exports.default;
            };
          };
        };
      };
    };
}
