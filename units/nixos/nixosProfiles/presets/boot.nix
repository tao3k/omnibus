{
  imports = [ omnibus.nixosModules.boot ];
  boot.__profiles__.systemd-boot.enable = true;
  boot.__profiles__.speedup = true;
}
