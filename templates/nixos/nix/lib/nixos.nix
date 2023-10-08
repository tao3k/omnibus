{
  loadHomeModules =
    (omnibus.pops.loadHomeModules.addLoadExtender {
      load.src = self'.outPath + "/nixos/homeModules";
    });

  loadHomeProfiles =
    (omnibus.pops.loadHomeProfiles.addLoadExtender {
      load = {
        src = self'.outPath + "/nixos/homeProfiles";
        inputs = {
          homeModules = self.loadHomeModules.layouts.default;
        };
      };
    });

  loadNixOSProfiles =
    (omnibus.pops.loadNixOSProfiles.addLoadExtender {
      load = {
        src = self'.outPath + "/nixos/nixosProfiles";
        inputs = {
          nixosModules = self.loadNixOSModules.layouts.default;
        };
      };
    });

  loadNixOSModules =
    (omnibus.pops.loadNixOSModules.addLoadExtender {
      load.src = self'.outPath + "/nixos/nixosModules";
    });

  loadDarwinProfiles =
    (omnibus.pops.loadNixOSProfiles.addLoadExtender {
      load.src = self'.outPath + "/nixos/darwinProfiles";
    });

  loadDarwinModules =
    (omnibus.pops.loadNixOSModules.addLoadExtender {
      load.src = self'.outPath + "/nixos/darwinModules";
    });
}
