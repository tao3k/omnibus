# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs,
  omnibus,
  config,
  lib,
}:
let
  cfg = config.disko.devices;
  inherit
    (omnibus.errors.requiredInputs inputs "omnibus.pops.nixosProfiles" ["disko"])
    disko
    ;
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
              };
            })
            // {
              ESP = {
                size = "256M";
                name = "boot";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"]; # Override existing partition
                  # Subvolumes must set a mountpoint in order to be mounted,
                  # unless their parent is mounted
                  subvolumes = {
                    # Subvolume name is different from mountpoint
                    "/rootfs" = {
                      mountpoint = "/";
                    };
                    # Subvolume name is the same as the mountpoint
                    "/home" = {
                      mountOptions = ["compress=zstd"];
                      mountpoint = "/home";
                    };
                    # Parent is not mounted so the mountpoint must be set
                    "/nix" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                      mountpoint = "/nix";
                    };
                    "/persist" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                      mountpoint = "/persist";
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
          "mode=755"
        ];
      };
    };
  };
}
