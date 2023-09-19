{
  selfNixOSProfiles = super.pops.selfNixOSProfiles.outputsForTarget.default;

  nixosModules = super.pops.nixosModules.outputsForTarget.nixosModules;

  nixosSuites = lib.flatten [
    self.selfNixOSProfiles.bootstrap
    self.nixosModules.boot
    self.nixosModules.programs.git
  ];
}
