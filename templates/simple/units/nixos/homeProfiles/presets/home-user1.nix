{ config }:
{
  home = {
    username = "your-username";
    homeDirectory = "/home/your-username";
  };
  systemd.user.startServices = "sd-switch";
  home.stateVersion = "23.05";
}
