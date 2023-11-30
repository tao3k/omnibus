# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{config, lib, ...}:
{
  config =
    with lib;
    mkMerge [
      {
        services.xserver.enable = true;
        services.xserver.displayManager.gdm.enable = true;
      }
      (mkIf config.programs.xwayland.enable {
        services.xserver.displayManager.gdm.wayland = true;
      })
    ];
}
