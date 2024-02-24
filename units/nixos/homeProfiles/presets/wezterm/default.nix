# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.wezterm;
  inherit (inputs.cells.common.lib) __utils__;

  src = profiles + "/wezterm";
in
{
  config =
    with lib;
    mkMerge [
      (mkIf (cfg.enable && nixpkgs.stdenv.isLinux) {
        programs.wezterm = {
          package = pkgs.wezterm;
        };
      })
      {
        home.file.".config/wezterm/catppuccin.lua".source =
          __utils__.catppuccin-wezterm + "/catppuccin.lua";
        home.file.".config/wezterm/wezterm.lua".source = "${src}/wezterm.lua";
      }
    ];
}
