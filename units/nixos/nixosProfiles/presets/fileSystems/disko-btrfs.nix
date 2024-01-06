# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# https://github.com/openlab-aux/vuizvui/blob/57a02c9b4a36abadc020008a9e5a85315b58bb54/machines/aszlig/meshuggah.nix#L19
{
  inputs,
  omnibus,
  config,
  lib,
}:
let
  cfg = config.disko.devices;
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.nixosProfiles" [
      "disko"
    ])
    disko
    ;
  ssdMountOptions = lib.optionals cfg.__profiles__.ssd [
    "discard"
    "ssd"
    "space_cache"
  ];
  commonMountOptions = [
    "noatime"
    "compress=zstd"
    # hardening options
    "nosuid"
    "nodev"
  ];
in
{
  imports = [
    disko.nixosModules.disko
    omnibus.nixosModules.disko
  ];
  disko.devices = {
    disk = {
      "${cfg.__profiles__.name}" = {
        type = "disk";
        device = cfg.__profiles__.device;
        content = {
          type = "gpt";
          partitions =
            (lib.optionalAttrs cfg.__profiles__.boot {
              BOOT = {
                size = "1M";
                type = "EF02"; # for grub MBR
                priority = 0;
              };
            })
            // {
              ESP = {
                size = "256M";
                name = "boot";
                type = "EF00";
                priority = if cfg.__profiles__.boot then 1 else 0;
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [
                    "nodev"
                    "noexec"
                    "nosuid"
                  ];
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ]; # Override existing partition
                  # Subvolumes must set a mountpoint in order to be mounted,
                  # unless their parent is mounted
                  subvolumes = {
                    # Subvolume name is different from mountpoint
                    "/rootfs" = {
                      mountpoint = "/";
                      mountOptions = [ ] ++ commonMountOptions ++ ssdMountOptions;
                    };
                    # Subvolume name is the same as the mountpoint
                    "/home" = {
                      mountOptions = [ ] ++ commonMountOptions ++ ssdMountOptions;
                      mountpoint = "/home";
                    };
                    # Parent is not mounted so the mountpoint must be set
                    "/nix" = {
                      mountOptions = [ ] ++ commonMountOptions ++ ssdMountOptions;
                      mountpoint = "/nix";
                    };
                    "/persist" = {
                      mountOptions = [ ] ++ commonMountOptions ++ ssdMountOptions;
                      mountpoint = "/persist";
                    };
                    "/swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "2G";
                    };
                  };
                };
              };
            };
        };
      };
    };
    nodev = {
      "/tmp" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
          "size=2G"
          "mode=1777"
          "nosuid"
          "nodev"
          "relatime"
        ] ++ ssdMountOptions;
      };
    };
  };
}
