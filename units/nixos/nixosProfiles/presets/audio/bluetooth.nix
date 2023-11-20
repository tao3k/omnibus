# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  omnibus,
  pkgs,
  lib,
}:
{
  imports = [ omnibus.nixosModules.hardware.bluetooth ];

  services.blueman.enable = true;

  environment.systemPackages =
    with pkgs;
    (lib.optionals config.hardware.bluetooth.__profiles__.desktop [
      lxqt.pavucontrol-qt
    ]);

  hardware.bluetooth = {
    package = pkgs.bluez5-experimental;
    enable = true;
    powerOnBoot = true;
  };

  environment = lib.mkIf config.hardware.bluetooth.enable {
    etc."wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };
}
