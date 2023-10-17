{ pkgs, ... }:
{
  services.yubikey-agent.enable = true;

  environment.systemPackages = with pkgs; [
    yubikey-manager
    yubico-piv-tool
  ];

  services.udev.packages = [ pkgs.yubikey-personalization ];
}
