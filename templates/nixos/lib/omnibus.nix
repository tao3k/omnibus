{
  loadHomeModules = (omnibus.loadHomeModules.addLoadExtender { });

  loadHomeProfiles = (omnibus.loadHomeProfiles.addLoadExtender { });

  loadNixOSProfiles = (omnibus.loadNixOSProfiles.addLoadExtender { });

  loadNixOSModules = (omnibus.loadNixOSModules.addLoadExtender { });

  lib = omnibus.lib.addLoadExtender {
    inputs = {
      home-manager = inputs.home;
    };
  };
}
