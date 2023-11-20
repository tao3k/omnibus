# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  programs.dircolors = {
    enable = true;
    extraConfig = builtins.readFile (omnibus.dotfiles + "/dircolors/LS_COLORS");
  };
}
