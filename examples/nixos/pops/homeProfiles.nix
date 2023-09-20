loadHomeProfiles.addLoadExtender {
  inputs = super.inputs__.outputs // {
    POS = {
      homeModules = super.homeModules.outputsForTarget.nixosModules;
    };
  };
}
