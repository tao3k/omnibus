# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ config, lib, ... }:
{
  # https://github.com/Canop/broot
  programs.broot = {
    enable = true;
    enableZshIntegration = lib.mkIf config.programs.zsh.enable true;
    enableBashIntegration = lib.mkIf config.programs.bash.enable true;
  };
}
