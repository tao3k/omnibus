# SPDX-FileCopyrightText: 2023 The omnibus Authors
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
