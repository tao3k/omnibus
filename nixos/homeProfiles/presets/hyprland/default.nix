{
  imports = [ POS.homeModules.wayland.windowManager.hyprland ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    # extraConfig = builtins.readFile "${src}/hyprland.conf";
    xwayland = {
      enable = true;
    };
    __profiles__ = {
      nvidia = false;
      autoLogin = {
        enable = true;
        shell = "zsh";
      };
      swww = true;
    };
  };
}
