{omnibus, lib}:
{
  # zram
  imports = [omnibus.nixosModules.services.zswap];
  zramSwap.enable = lib.mkForce false;
  services.zswap = {
    enable = true;
    zpool = lib.mkDefault "zsmalloc";
  };
}
