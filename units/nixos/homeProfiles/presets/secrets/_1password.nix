# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{pkgs, ...}:
{
  home.packages = with pkgs; [
    _1password-gui
    _1password
  ];
}
