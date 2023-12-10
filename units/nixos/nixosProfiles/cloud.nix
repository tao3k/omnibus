# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# [[file:../../../docs/org/nixosProfiles.org::*cloud][cloud:1]]
{
  root,
  omnibus,
  POP,
  flops,
  lib,
}:
let
  inherit (lib.omnibus) mkSuites;
  srvosCustom =
    (omnibus.pops.srvos.addExporters [
      (POP.extendPop flops.haumea.pops.exporter (
        self: _super: {
          exports.srvosCustom = self.outputs [
            {
              value = {selfModule}: removeAttrs selfModule ["imports"];
              path = [
                "common"
                "default"
              ];
            }
          ];
        }
      ))
    ]).layouts.srvosCustom;

  presets = root.presets;
in
with presets;
mkSuites {
  default = [
    {
      keywords = [
        "srvos"
        "server"
        "presets"
        "init"
      ];
      knowledges = ["https://github.com/nix-community/srvos"];
      profiles = [
        nix
        openssh
        srvosCustom.common.default
        srvosCustom.common.serial
        srvosCustom.common.sudo
        srvosCustom.common.upgrade-diff
        srvosCustom.mixins.nix-experimental
        (
          {pkgs, lib, ...}:
          {
            boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
            boot.tmp.cleanOnBoot = true;
            documentation.enable = false;
          }
        )
      ];
    }
    {
      keywords = [
        "zswap"
        "memory"
        "optimization"
        "compression"
      ];
      knowledges = ["https://wiki.archlinux.org/title/zswap"];
      profiles = [zswap];
    }
  ];

  btrfs = [
    fileSystems.btrfs
    fileSystems.disko-btrfs
    fileSystems.impermanence
  ];

  contabo = [
    self.default
    cloud.contabo
    {
      keywords = [
        "disko"
        "boot"
      ];
      knowledges = [""];
      profiles = [
        self.btrfs
        {
          boot.loader.grub.device = "";
          disko.devices.__profiles__ = {
            boot = true;
            name = "sda";
            device = "/dev/sda";
          };
        }
      ];
    }
  ];
}
# cloud:1 ends here
