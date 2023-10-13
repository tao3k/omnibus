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
      } // lib.exporter.flakeOutputs;

      libPops = import ./lib/__init.nix { inherit inputs omnibus; };
      lib = libPops.layouts.default;
    in
    lib.exporter.flakeOutputs
    // {
      pops = lib.exporter.pops // {
        lib = libPops;
      };

      inherit lib;

      templates.default = {
        path = ./templates/nixos;
        description = "Omnibus & nixos";
        welcomeText = ''
          You have created an Omnibus.nixos template!
        '';
      };
    }
  ;
}
