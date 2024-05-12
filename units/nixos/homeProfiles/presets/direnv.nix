# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT
{
  pkgs,
  omnibus,
  config,
  lib,
}:
let
  flake_env =
    (pkgs.extend omnibus.flake.inputs.flake_env.overlays.default).flake_env;
in
{
  programs.direnv = {
    enable = true;
    enableZshIntegration = lib.mkIf config.programs.zsh.enable true;
    enableBashIntegration = lib.mkIf config.programs.bash.enable true;
    enableNushellIntegration = lib.mkIf config.programs.nushell.enable true;
    nix-direnv = {
      enable = true;
    };
    # stdlib = ''
    #   . ${flake_env}/share/flake_env/direnvrc
    # '';
  };
}
