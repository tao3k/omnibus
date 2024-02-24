# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ config, lib, ... }:
{
  config =
    with lib;
    mkMerge [
      {
        services.xserver.enable = true;
        services.xserver.displayManager.lightdm.enable = true;
      }
    ];
}
