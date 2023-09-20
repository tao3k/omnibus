super.nixosProfiles.addLoadExtender {
  src = ../__nixosProfiles;
  loader = haumea.loaders.scoped;
  type = "nixosProfiles";
  inputs = {
    POS = {
      nixosProfiles = super.nixosProfiles.outputsForTarget.nixosProfiles;
    };
  };
}
