# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  config =
    with lib;
    mkMerge [
      (mkIf cfg.__profiles__.systemd-initrd.enable {
        boot.loader = {
          # timeout = 0;
          efi.canTouchEfiVariables = true;
          # https://discourse.nixos.org/t/configure-grub-on-efi-system/2926/7
          grub = {
            enable = true;
            efiSupport = true;
            device = "nodev";
            useOSProber = true;
          };
        };
        boot.initrd = {
          systemd = {
            enable = true;
            emergencyAccess = true;
          };
        };
      })
    ];

  options = with lib; {
    boot.__profiles__.systemd-initrd.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable systemd-initrd as bootloader.";
    };
  };
}
