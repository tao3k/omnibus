let
  inherit (moduleArgs) pkgs;
in
{
  imports = [ POS.homeModules.programs.bat ];
  programs.bat = {
    enable = true;
    __profiles__.catppuccin-mocha.enable = true;
    extraPackages = with pkgs.bat-extras; [ batman ];
  };
}
