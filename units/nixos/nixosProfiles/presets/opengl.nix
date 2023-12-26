{ pkgs, lib }:
{
  hardware.opengl = {
    driSupport = true;
    # driSupport32Bit = true;
  };
  hardware.opengl.package = lib.mkDefault pkgs.mesa.drivers;
}
