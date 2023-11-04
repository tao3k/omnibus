{
  modules = super.nixosModules.addLoadExtender {
    load.src = inputs.self.outPath + "/units/flake-parts/modules";
  };
  profiles = super.nixosProfiles.addLoadExtender {
    load = {
      src = inputs.self.outPath + "/units/flake-parts/profiles";
    };
  };
}
