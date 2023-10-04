{
  imports = [ omnibus.nixosProfiles.presets.boot ];
  boot.__profiles__.systemd-boot.enable = true;
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
  };
}
