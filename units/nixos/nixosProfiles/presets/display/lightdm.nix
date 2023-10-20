{ config, lib, ... }:
{
  config =
    with lib;
    mkMerge [
      {
        services.xserver.enable = true;
        services.xserver.displayManager.lightdm.enable = true;
      }
    ];
}
