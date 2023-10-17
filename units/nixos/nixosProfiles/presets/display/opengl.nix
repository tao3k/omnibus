{ pkgs, ... }:
{
  # hardware.opengl.extraPackages = with pkgs; [
  #   vaapiIntel
  #   vaapiVdpau
  #   libvdpau-va-gl
  #   intel-media-driver
  # ];
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.opengl.package = pkgs.mesa.drivers;
}
