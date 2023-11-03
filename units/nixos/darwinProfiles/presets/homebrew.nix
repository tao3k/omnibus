{ omnibus, lib }:
{
  imports = [ omnibus.darwinModules.homebrew ];
  homebrew = {
    __profiles__ = {
      enableShell = lib.mkDefault true;
      enableContainers = lib.mkDefault true;
      enableSecurity = lib.mkDefault true;
      enableChat = lib.mkDefault true;
      casks.removePackagesFromProfiles = [ ];
      brews.removePackagesFromProfiles = [ ];
    };
  };
}
