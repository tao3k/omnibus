{
  loadHomeModules =
    (omnibus.loadHomeModules.addLoadExtender { src = ../../nixos/homeModules; });

  loadHomeProfiles =
    (omnibus.loadHomeProfiles.addLoadExtender {
      src = ../../nixos/homeProfiles;
      inputs = {
        homeModules = self.loadHomeModules.outputs.default;
      };
    });

  loadNixOSProfiles =
    (omnibus.loadNixOSProfiles.addLoadExtender {
      src = ../../nixos/nixosProfiles;
      inputs = {
        nixosModules = self.loadNixOSModules.outputs.default;
      };
    });

  loadNixOSModules =
    (omnibus.loadNixOSModules.addLoadExtender { src = ../../nixos/nixosModules; });

  loadDarwinProfiles =
    (omnibus.loadNixOSProfiles.addLoadExtender {
      src = ../../nixos/darwinProfiles;
    });

  loadDarwinModules =
    (omnibus.loadNixOSModules.addLoadExtender { src = ../../nixos/darwinModules; });
}
