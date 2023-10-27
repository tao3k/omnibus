{ omnibus, lib }:
{
  imports = [ omnibus.darwinModules.homebrew ];
  homebrew = {
    __profiles__ = {
      shell = lib.mkDefault true;
      containers = lib.mkDefault true;
      security = lib.mkDefault true;
      chat = lib.mkDefault true;
      casks.removePackagesFromProfiles = [ ];
      brews.removePackagesFromProfiles = [ ];
    };
  };
}
