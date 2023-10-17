{
  security.polkit.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = [ "all" ];
    qemu = {
      runAsRoot = false;
    };
  };
}
