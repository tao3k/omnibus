let
  baseInputs = {
    inherit omnibus POP flops;
    inputs = {
      inherit (inputs) dmerge;
      inherit lib;
    };
  };
in
{
  loadInputs = flops.flake.pops.default.setInitInputs (
    inputs.self.outPath + "/local/lock"
  );

  loadData = flops.haumea.pops.default.setInit {
    loader = with haumea; [
      matchers.json
      matchers.toml
    ];
  };
  loadNixOSModules = flops.haumea.pops.default.setInit {
    src = inputs.self.outPath + "/nixos/nixosModules";
    type = "nixosModules";
    inputs = baseInputs;
  };
  loadHomeModules = flops.haumea.pops.default.setInit {
    src = inputs.self.outPath + "/nixos/homeModules";
    type = "nixosModules";
    inputs = baseInputs;
  };
  loadHomeProfiles = self.loadHomeModules.addLoadExtender {
    load = {
      src = inputs.self.outPath + "/nixos/homeProfiles";
      loader = haumea.loaders.scoped;
      type = "nixosProfiles";
    };
  };

  loadNixOSProfiles = self.loadNixOSModules.addLoadExtender {
    load = {
      src = inputs.self.outPath + "/nixos/nixosProfiles";
      type = "nixosProfiles";
      transformer = [ (_: _: _) ];
    };
  };

  loadDarwinProfiles = self.loadNixOSProfiles.addLoadExtender {
    load = {
      src = inputs.self.outPath + "/nixos/darwinProfiles";
    };
  };

  loadDarwinModules = self.loadNixOSModules.addLoadExtender {
    load.src = inputs.self.outPath + "/nixos/darwinModules";
  };

  srvos = flops.haumea.pops.default.setInit {
    src = self.loadInputs.outputs.srvos + "/nixos";
    type = "nixosProfiles";
    # reset the transformer to the default
    transformer = [ (_: _: _) ];
  };
  flake-parts = {
    loadModules = self.loadNixOSModules.addLoadExtender {
      load.src = inputs.self.outPath + "/evalModules/flake-parts/modules";
    };
    loadProfiles = self.loadNixOSProfiles.addLoadExtender {
      load = {
        src = inputs.self.outPath + "/evalModules/flake-parts/profiles";
      };
    };
  };
  devshell = rec {
    loadModules = self.loadNixOSModules.addLoadExtender {
      load = {
        src = inputs.self.outPath + "/evalModules/devshell/modules";
        type = "nixosModules";
      };
    };
    loadProfiles = self.loadNixOSProfiles.addLoadExtender {
      load = {
        src = inputs.self.outPath + "/evalModules/devshell/profiles";
        type = "nixosProfiles";
      };
    };
  };

  exporter = flops.haumea.pops.default.setInit {
    loader = with haumea; loaders.scoped;
    inputs = {
      inputs.self = self;
      inherit
        omnibus
        POP
        haumea
        flops
        lib
      ;
      inputs = {
        inherit (inputs) dmerge;
      };
    };
  };
}
