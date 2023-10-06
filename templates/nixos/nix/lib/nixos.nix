{
  loadHomeModules =
    (omnibus.pops.loadHomeModules.addLoadExtender {
      src = self'.outPath + "/nixos/homeModules";
    });

  loadHomeProfiles =
    (omnibus.pops.loadHomeProfiles.addLoadExtender {
      src = self'.outPath + "/nixos/homeProfiles";
      inputs = {
        homeModules = self.loadHomeModules.outputs.default;
      };
    });

  loadNixOSProfiles =
    (omnibus.pops.loadNixOSProfiles.addLoadExtender {
      src = self'.outPath + "/nixos/nixosProfiles";
      inputs = {
        nixosModules = self.loadNixOSModules.outputs.default;
      };
    });

  loadNixOSModules =
    (omnibus.pops.loadNixOSModules.addLoadExtender {
      src = self'.outPath + "/nixos/nixosModules";
    });

  loadDarwinProfiles =
    (omnibus.pops.loadNixOSProfiles.addLoadExtender {
      src = self'.outPath + "/nixos/darwinProfiles";
    });

  loadDarwinModules =
    (omnibus.pops.loadNixOSModules.addLoadExtender {
      src = self'.outPath + "/nixos/darwinModules";
    });
}
