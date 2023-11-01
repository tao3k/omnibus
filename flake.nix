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
      } // lib.flakeOutputs;

      library = import ./lib/__init.nix { inherit inputs omnibus; };
      lib = library.layouts.default;
    in
    lib.flakeOutputs
    // {
      pops = lib.pops // {
        lib = library;
      };

      inherit lib;

      templates = {
        nixos = {
          path = ./templates/nixos;
          description = "Omnibus & nixos";
          welcomeText = ''
            You have created an Omnibus.nixos template!
          '';
        };
        hivebus = {
          path = ./templates/hivebus;
          description = "Omnibus & hive";
          welcomeText = ''
            You have created a hivebus template!
          '';
        };
        simple = {
          path = ./templates/simple;
          description = "Omnibus & simple case";
          welcomeText = ''
            You have created a simple case template!
          '';
        };
      };
    };
}
