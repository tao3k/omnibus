# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{pkgs, ...}:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    extraConfig =
      (if pkgs.stdenv.isLinux then "" else "")
      + ''
        set -g prefix C-b
        bind C-b send-prefix

        #https://github.com/gpakosz/.tmux/issues/53
        set -gu prefix2

        unbind C-a

        set -g @resurrect-capture-pane-contents "on"

        set -g mouse on
        bind P paste-buffer
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi y send-keys -X copy-selection
        bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
      '';

    plugins = with pkgs.tmuxPlugins; [
      sidebar
      yank
      fingers
      sensible
      continuum
      resurrect
      power-theme
    ];
  };
}
