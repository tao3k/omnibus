let
  __inputs__ =
    (loadInputs.addInputsExtender (
      POP.extendPop flops.flake.pops.inputsExtender (
        self: super: { inputs.nixpkgs = nixpkgs.legacyPackages; }
      )
    )).setSystem
      "x86_64-linux";

  nixosModules =
    (loadNixOSModules.addLoadExtender { inputs = __inputs__.outputs // { }; });

  nixosProfiles = loadNixOSProfiles.addLoadExtender {
    inputs = __inputs__.outputs // {
      POS = {
        nixosModules = nixosModules.outputsForTarget.nixosModules;
      };
    };
  };

  homeProfiles = loadHomeProfiles.addLoadExtender {
    inputs = __inputs__.outputs // {
      POS = {
        homeModules = homeModules.outputsForTarget.nixosModules;
      };
    };
  };

  selfNixOSProfiles = nixosProfiles.addLoadExtender {
    src = ./__nixosProfiles;
    loader = haumea.loaders.scoped;
    type = "default";
    inputs = {
      POS = {
        nixosProfiles = nixosProfiles.outputsForTarget.nixosProfiles;
      };
    };
  };

  homeModules = loadHomeModules.addLoadExtender {
    inputs = __inputs__.outputs // { };
  };
in
{
  inherit
    __inputs__
    selfNixOSProfiles
    nixosModules
    nixosProfiles
    homeModules
    homeProfiles
  ;
}
