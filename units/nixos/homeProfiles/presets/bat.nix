# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  imports = [ omnibus.homeModules.programs.bat ];
  programs.bat = {
    enable = true;
    __profiles__.catppuccin-themes.name = "mocha";
    extraPackages = with pkgs.bat-extras; [ batman ];
  };
}
