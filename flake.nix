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
      lib = flops.lib.haumea.pops.default.setInit {
        src = ./lib;
        loader = haumea.lib.loaders.scoped;
        inputs = {
          lib = flops.inputs.nixlib.lib // builtins;
          home-manager = self.lib.loadInputs.outputs.home-manager;
        };
      };

      nixosConfigurations =
        (self.exporters.addLoadExtender {
          src = ./nixos/nixosConfigurations;
          inputs = {
            nixpkgs = self.lib.loadInputs.outputs.nixpkgs;
            exporters = self.exporters.outputs.default;
          };
        }).outputs.default;
    in
    {
      inherit nixosConfigurations;
      lib = {
        dotfiles = ./dotfiles;
        loadInputs = flops.lib.flake.pops.default.setInitInputs ./local/lock;
        loadData = flops.lib.haumea.pops.default.setInit {
          src = ./examples/__data;
          loader = with inputs.flops.inputs.haumea.lib; [
            matchers.json
            matchers.toml
          ];
        };
        loadNixOSModules = flops.lib.haumea.pops.default.setInit {
          src = ./nixos/nixosModules;
          type = "nixosModules";
          inputs = {
            POP = POP.lib;
            flops = flops.lib;
            omnibus = self.lib;
          };
        };
        loadHomeModules = flops.lib.haumea.pops.default.setInit {
          src = ./nixos/homeModules;
          type = "nixosModules";
          inputs = {
            omnibus = self.lib;
            inherit (self.lib) dotfiles;
          };
        };
        loadHomeProfiles = self.lib.loadHomeModules.addLoadExtender {
          src = ./nixos/homeProfiles;
          loader = haumea.lib.loaders.scoped;
          type = "nixosProfiles";
        };
        loadNixOSProfiles = self.lib.loadNixOSModules.addLoadExtender {
          src = ./nixos/nixosProfiles;
          type = "nixosProfiles";
        };
        srvos = flops.lib.haumea.pops.default.setInit {
          src = builtins.unsafeDiscardStringContext (
            self.lib.loadInputs.outputs.srvos + "/nixos"
          );
          type = "nixosProfiles";
          # reset the transformer to the default
          transformer = [ (_: _: _) ];
        };
        evalModules = {
          flake-parts = {
            loadModules = self.lib.loadNixOSModules.addLoadExtender {
              src = ./evalModules/flake-parts/modules;
            };
            loadProfiles = self.lib.loadNixOSProfiles.addLoadExtender {
              src = ./evalModules/flake-parts/profiles;
              inputs = {
                omnibus.evalModules.flake-parts.modules =
                  self.evalModules.flake-parts.modules.outputs.default;
              };
            };
          };
          devshell = rec {
            loadModules = self.lib.loadNixOSModules.addLoadExtender {
              src = ./evalModules/devshell/modules;
              type = "nixosModules";
            };
            loadProfiles = self.lib.loadNixOSProfiles.addLoadExtender {
              src = ./evalModules/devshell/profiles;
              type = "nixosProfiles";
              inputs = {
                omnibus.devshellModules = loadModules.outputs.default;
              };
            };
          };
        };
        lib = lib.outputs.default;
      };
      exporters = flops.lib.haumea.pops.default.setInit {
        loader = with haumea.lib; loaders.scoped;
        src = ./examples;
        inputs = {
          lib = flops.inputs.nixlib.lib // builtins;
          flops = flops.lib;
          haumea = flops.inputs.haumea.lib;
          dmerge = flops.inputs.dmerge;
          POP = POP.lib;
          omnibus = self.lib;
        };
      };
    };
}
