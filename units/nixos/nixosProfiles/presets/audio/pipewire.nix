{ lib, config }:
{
  security.rtkit.enable = lib.mkDefault config.services.pipewire.enable;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
