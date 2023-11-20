# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  programs.atuin = {
    # credit: https://github.com/montchr/dotfield/commit/6237fa7cde4b6fc1ba5b28234e5ce0c295c7bff9#diff-e85828e2a1e40863d27b847846b1f592b906fd9fa495f89b52057125bcc992f7
    enable = true;
    enableBashIntegration = lib.mkIf config.programs.bash.enable true;
    enableZshIntegration = lib.mkIf config.programs.zsh.enable true;
    enableNushellIntegration = lib.mkIf config.programs.nushell.enable true;
    enableFishIntegration = lib.mkIf config.programs.fish.enable true;
    settings = {
      auto_sync = true;
      dialect = "us";
      sync_frequency = "10m";
      sync_address = "https://api.atuin.sh";
      search_mode = "fuzzy"; # 'prefix' | 'fulltext' | 'fuzzy'

      ##: options: 'global' (default) | 'host' | 'session' | 'directory'
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "directory";
    };
  };
}
