_:
{ pkgs, ... }:
{
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  environment.systemPackages = with pkgs; [ libsecret ];
}
