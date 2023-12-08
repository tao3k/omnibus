# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  imports = [omnibus.homeModules.programs.foliate];
  programs.foliate = {
    enable = true;
    __profiles__.themes = {
      catppuccin-foliate = {
        enable = true;
      };
    };
  };
}
