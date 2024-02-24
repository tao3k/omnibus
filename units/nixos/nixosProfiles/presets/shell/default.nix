# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  pkgs,
  lib,
  config,
  ...
}:
{
  config =
    with lib;
    mkMerge [ { environment.systemPackages = with pkgs; [ just ]; } ];
}
