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

  data = flops.haumea.pops.default.setInit {
    loader = with haumea; [
      matchers.json
      matchers.toml
    ];
  };
  dataAll =
    (self.data.addLoadExtender {
      load = {
        loader = with haumea; [
          (matchers.regex "^(.+)\\.(yaml|yml)$" (
            _: _: path:
            root.readYAML path
          ))
        ];
      };
    });

  nixosModules = flops.haumea.pops.default.setInit {
    src = inputs.self.outPath + "/units/nixos/nixosModules";
    type = "nixosModules";
    inputs = baseInputs;
  };
  homeModules = flops.haumea.pops.default.setInit {
    src = inputs.self.outPath + "/units/nixos/homeModules";
    type = "nixosModules";
    inputs = baseInputs;
  };
  homeProfiles = self.homeModules.addLoadExtender {
    load = {
      src = inputs.self.outPath + "/units/nixos/homeProfiles";
      loader = haumea.loaders.scoped;
      type = "nixosProfiles";
      transformer = [ (_: _: _) ];
    };
  };

  nixosProfiles = self.nixosModules.addLoadExtender {
    load = {
      src = inputs.self.outPath + "/units/nixos/nixosProfiles";
      type = "nixosProfiles";
      transformer = [ (_: _: _) ];
    };
  };

  darwinProfiles = self.nixosProfiles.addLoadExtender {
    load = {
      src = inputs.self.outPath + "/units/nixos/darwinProfiles";
    };
  };

  darwinModules = self.nixosModules.addLoadExtender {
    load.src = inputs.self.outPath + "/units/nixos/darwinModules";
  };

  configs = flops.haumea.pops.default.setInit {
    src = inputs.self.outPath + "/units/configs";
    inputs = baseInputs;
  };

  srvos = flops.haumea.pops.default.setInit {
    src = self.loadInputs.outputs.srvos + "/nixos";
    type = "nixosProfiles";
    # reset the transformer to the default
    transformer = [ (_: _: _) ];
  };
  flake-parts = {
    modules = self.nixosModules.addLoadExtender {
      load.src = inputs.self.outPath + "/units/flake-parts/modules";
    };
    profiles = self.nixosProfiles.addLoadExtender {
      load = {
        src = inputs.self.outPath + "/units/flake-parts/profiles";
      };
    };
  };

  devshellModules = self.nixosModules.addLoadExtender {
    load = {
      src = inputs.self.outPath + "/units/devshell/modules";
      type = "nixosModules";
    };
  };
  devshellProfiles = self.nixosProfiles.addLoadExtender {
    load = {
      src = inputs.self.outPath + "/units/devshell/profiles";
      type = "nixosProfiles";
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
