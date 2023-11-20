# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  pkgs,
  config,
  lib,
  ...
}:
{
  config =
    with lib;
    mkMerge [
      (mkIf
        (
          config.virtualisation.__profiles__.gui && config.virtualisation.libvirtd.enable
        )
        {
          environment.systemPackages = with pkgs; [
            pkgs.virt-manager
            spice-gtk
          ];
        }
      )
    ];
}
