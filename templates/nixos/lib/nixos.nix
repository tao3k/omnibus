{
  loadHomeModules =
    (omnibus.loadHomeModules.addLoadExtender { src = ../nixos/homeModules; });

  loadHomeProfiles =
    (omnibus.loadHomeProfiles.addLoadExtender { src = ../nixos/homeProfiles; });

  loadNixOSProfiles =
    (omnibus.loadNixOSProfiles.addLoadExtender { src = ../nixos/nixosProfiles; });

  loadNixOSModules =
    (omnibus.loadNixOSModules.addLoadExtender { src = ../nixos/nixosModules; });

  loadDarwinProfiles =
    (omnibus.loadNixOSProfiles.addLoadExtender { src = ../nixos/darwinProfiles; });

  loadDarwinModules =
    (omnibus.loadNixOSModules.addLoadExtender { src = ../nixos/darwinModules; });
}
