# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ omnibus, lib }:
{
  imports = [ omnibus.homeModules.programs.alacritty ];
  programs.alacritty = {
    enable = true;
    CSIuSupport = true;
    settings = {
      env.TERM = "xterm-256color";
      window.decorations = "full";
      cursor.style = "Beam";
      window.opacity = 0.7;
      # snazzy theme
      colors = {
        # Default colors
        primary = {
          background = "0x282a36";
          foreground = "0xeff0eb";
        };

        # Normal colors
        normal = {
          black = "0x282a36";
          red = "0xff5c57";
          green = "0x5af78e";
          yellow = "0xf3f99d";
          blue = "0x57c7ff";
          magenta = "0xff6ac1";
          cyan = "0x9aedfe";
          white = "0xf1f1f0";
        };

        # Bright colors
        bright = {
          black = "0x686868";
          red = "0xff5c57";
          green = "0x5af78e";
          yellow = "0xf3f99d";
          blue = "0x57c7ff";
          magenta = "0xff6ac1";
          cyan = "0x9aedfe";
          white = "0xf1f1f0";
        };
      };
    };
  };
}
