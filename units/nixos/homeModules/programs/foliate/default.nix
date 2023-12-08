# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  lib,
  loadSrc,
  cfg,
  inputs,
  config,
}:
with lib; {
  options = {
    enable = mkEnableOption (lib.mdDoc "Whether to enable foliate");
    __profiles__ = {
      themes =
        (import (loadSrc + "/_common/themes.nix") {inherit lib inputs;}).themes;
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {home.packages = [pkgs.foliate];})
    (mkIf
      (
        hasAttr "catppuccin-foliate" cfg.__profiles__.themes
        && cfg.__profiles__.themes.catppuccin-foliate.enable
      )
      {
        xdg.configFile."com.github.johnfactotum.Foliate/themes.json".source =
          cfg.__profiles__.themes.catppuccin-foliate.src + "/themes.json";
      }
    )
  ];
}
