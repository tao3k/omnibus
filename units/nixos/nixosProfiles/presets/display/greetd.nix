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
        services.greetd = {
          enable = true;
        };
      }
    ];
}
