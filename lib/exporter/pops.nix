{
  dotfiles = self'.outPath + "/dotfiles";
  loadInputs = flops.flake.pops.default.setInitInputs (
    self'.outPath + "/local/lock"
  );
  loadData = flops.haumea.pops.default.setInit {
    loader = with haumea; [
      matchers.json
      matchers.toml
    ];
  };
  loadNixOSModules = flops.haumea.pops.default.setInit {
    src = self'.outPath + "/nixos/nixosModules";
    type = "nixosModules";
    inputs = {
      POP = POP.lib;
      flops = flops.lib;
      omnibus = self;
    };
  };
  loadHomeModules = flops.haumea.pops.default.setInit {
    src = self'.outPath + "/nixos/homeModules";
    type = "nixosModules";
    inputs = {
      omnibus = self;
      dotfiles = self.dotfiles;
    };
  };
  loadHomeProfiles = self.loadHomeModules.addLoadExtender {
    load = {
      src = self'.outPath + "/nixos/homeProfiles";
      loader = haumea.loaders.scoped;
      type = "nixosProfiles";
    };
  };
  loadNixOSProfiles = self.loadNixOSModules.addLoadExtender {
    load = {
      src = self'.outPath + "/nixos/nixosProfiles";
      type = "nixosProfiles";
    };
  };
  srvos = flops.haumea.pops.default.setInit {
    src = builtins.unsafeDiscardStringContext (
      self.loadInputs.outputs.srvos + "/nixos"
    );
    type = "nixosProfiles";
    # reset the transformer to the default
    transformer = [ (_: _: _) ];
  };
  evalModules = {
    flake-parts = {
      loadModules = self.loadNixOSModules.addLoadExtender {
        load.src = self'.outPath + "/evalModules/flake-parts/modules";
      };
      loadProfiles = self.loadNixOSProfiles.addLoadExtender {
        load = {
          src = self'.outPath + "/evalModules/flake-parts/profiles";
          inputs = {
            omnibus.evalModules.flake-parts.modules =
              self.evalModules.flake-parts.modules.layouts.default;
          };
        };
      };
    };
    devshell = rec {
      loadModules = self.loadNixOSModules.addLoadExtender {
        load = {
          src = self'.outPath + "/evalModules/devshell/modules";
          type = "nixosModules";
        };
      };
      loadProfiles = self.loadNixOSProfiles.addLoadExtender {
        load = {
          src = self'.outPath + "/evalModules/devshell/profiles";
          type = "nixosProfiles";
          inputs = {
            omnibus.devshellModules = loadModules.layouts.default;
          };
        };
      };
    };
  };

  exporter = flops.haumea.pops.default.setInit {
    loader = with haumea; loaders.scoped;
    inputs = {
      self' = self;
      inherit
        omnibus
        POP
        haumea
        flops
        lib
        dmerge
      ;
    };
  };
}
