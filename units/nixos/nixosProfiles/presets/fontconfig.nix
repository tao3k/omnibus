# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
{
  fonts.fontconfig = {
    antialias = true;
    hinting.enable = true;
    subpixel.lcdfilter = "default";
  };
}
