# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT'

{
  config =
    with lib;
    mkMerge [
      (mkIf (cfg.__profiles__.catppuccin-themes.name != "") {
        config = {
          theme = "Catppuccin-${cfg.__profiles__.catppuccin-themes.name}";
          style = "changes,header";
        };
        # bat cache --build
        themes = {
          Catppuccin-mocha = builtins.readFile (
            catppuccin-bat
            + "/Catppuccin-${cfg.__profiles__.catppuccin-themes.name}.tmTheme"
          );
        };
      })
    ];

  options.__profiles__ = with lib; {
    catppuccin-themes = mkOption {
      default = { };
      type = types.submodule {
        options = {
          name = mkOption {
            type = types.enum [
              "mocha"
              "macchiato"
              "latte"
              "frappe"
            ];
            default = "";
          };
        };
      };
    };
  };
}
