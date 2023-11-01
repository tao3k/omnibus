{ lib }:
{
  options = with lib; {
    __profiles__ = {
      navi-tldr-pages = {
        enable = mkEnableOption (mdDoc "navi-tldr-pages");
        package = pkgs.tldr;
      };
    };
  };
}
