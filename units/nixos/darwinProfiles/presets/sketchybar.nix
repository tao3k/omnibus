# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{pkgs}:
{
  services.sketchybar = {
    extraPackages = [
      pkgs.jq
      pkgs.gh
      pkgs.ripgrep
      # pkgs.ical-buddy
      # pkgs.sketchybar-cpu-helper
    ];
    enable = true;
  };
  launchd.user.agents.sketchybar = {
    serviceConfig = {
      StandardOutPath = "/tmp/sketchybar.log";
      StandardErrorPath = "/tmp/sketchybar.log";
    };
  };
}
