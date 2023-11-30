# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{config, lib}:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = lib.mkIf config.programs.zsh.enable true;
    enableBashIntegration = lib.mkIf config.programs.bash.enable true;
    enableNushellIntegration = lib.mkIf config.programs.nushell.enable true;
    enableFishIntegration = lib.mkIf config.programs.fish.enable true;
    settings = lib.mkDefault (lib.importTOML ./starship.toml);
  };
}
