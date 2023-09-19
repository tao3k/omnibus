let
  __inputs__ =
    (loadInputs.addInputsExtender (
      POP.extendPop flops.flake.pops.inputsExtender (
        self: super: { inputs.nixpkgs = nixpkgs.legacyPackages; }
      )
    )).setSystem
      "x86_64-linux";
  nixosModules =
    (loadModules.addLoadExtender { inputs = __inputs__.outputs // { }; });

  selfNixOSProfiles = nixosModules.addLoadExtender {
    src = ./__nixosProfiles;
    loader = haumea.loaders.scoped;
    type = "default";
  };
in
{
  inherit __inputs__ selfNixOSProfiles nixosModules;
}
