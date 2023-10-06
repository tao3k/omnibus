{ lib }:
{
  options.__profiles__ = with lib; {
    desktop = mkEnableOption (lib.mdDoc "Whether to enable desktop profile");
  };
}
