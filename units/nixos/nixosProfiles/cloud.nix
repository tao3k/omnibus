# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# [[file:../../../docs/org/nixosProfiles.org::*cloud][cloud:1]]
{
  root,
  omnibus,
  POP,
  flops,
}:
let
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
with presets; {
  default = [
    srvosCustom.common.default
    openssh
    zswap
    {
      services.zswap.zpool = "z3fold";
      boot.tmp.cleanOnBoot = true;
      zramSwap.enable = true;
      documentation.enable = false;
    }
  ];

  brtfs-base = [
    fileSystems.btrfs
    fileSystems.impermanence
  ];

  btrfs-boot = [
    self.brtfs-base
    fileSystems.disko-btrfs-boot
  ];

  contabo = [
    self.default
    contabo
    self.btrfs-boot
    {
      boot.loader.grub.device = "";
      disko.devices.__profiles__ = {
        name = "sda";
        device = "/dev/sda";
      };
    }
  ];
}
# cloud:1 ends here
