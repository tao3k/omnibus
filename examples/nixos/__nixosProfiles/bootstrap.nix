{
  boot.__profiles__.systemd-boot.enable = true;
  # config.boot.__profiles__.systemd-initrd.enable = true;
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
  };
}
