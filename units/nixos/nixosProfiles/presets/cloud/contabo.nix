# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  config =
    with lib;
    mkMerge [
      ({
        boot.initrd = {
          systemd = {
            enable = true;
          };
        };
        boot.loader.grub = {
          device = lib.mkDefault "/dev/sda";
          efiSupport = false;
          enable = true;
        };
        boot.initrd = {
          availableKernelModules = [
            "virtio_pci" # disk
            "virtio_scsi" # disk
            "ata_piix"
            "uhci_hcd"
            "xen_blkfront"
            "vmw_pvscsi"
          ];
          kernelModules = [
            "dm-snapshot"
            "nvme"
          ];
        };
        networking = {
          useDHCP = lib.mkDefault true;
          # IPv6 connectivity
          # See also: https://contabo.com/blog/adding-ipv6-connectivity-to-your-server/
          defaultGateway6 = {
            address = "fe80::1";
            interface = "ens18";
          };
          interfaces.ens18.useDHCP = lib.mkDefault true;
        };
      })
    ];
}
