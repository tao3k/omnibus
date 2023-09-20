{
  imports = [ POS.nixosModules.boot ];
  boot.__profiles__.systemd-boot.enable = true;
}
