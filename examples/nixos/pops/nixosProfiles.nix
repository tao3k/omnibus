loadNixOSProfiles.addLoadExtender {
  inputs = super.inputs__.outputs // {
    POS = {
      nixosModules = super.nixosModules.outputsForTarget.nixosModules;
    };
  };
}
