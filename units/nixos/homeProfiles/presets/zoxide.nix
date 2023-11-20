# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  programs.zoxide = {
    enable = true;
    enableBashIntegration = lib.mkIf config.programs.bash.enable true;
    enableZshIntegration = lib.mkIf config.programs.zsh.enable true;
    enableNushellIntegration = lib.mkIf config.programs.nushell.enable true;
    enableFishIntegration = lib.mkIf config.programs.fish.enable true;
  };
}
