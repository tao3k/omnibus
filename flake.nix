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
      lib = import ./lib/__init.nix { inherit inputs omnibus; };
    in
    {
      pops = lib.layouts.default.exporter.pops // {
        inherit lib;
      };

      lib = lib.layouts.default;

      templates.default = {
        path = ./templates/nixos;
        description = "Omnibus & nixos";
        welcomeText = ''
          You have created an Omnibus.nixos template!
        '';
      };
    };
}
