# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ root, lib }:
let
  presets = root.presets;
  inherit (lib.omnibus) mkSuites;
in
mkSuites {
  networking = with presets; [
    {
      keywords = [
        "bbr"
        "optimization"
        "networking"
        "tcp"
      ];
      knowledges = [ "https://wiki.archlinux.org/title/sysctl#Networking" ];
      profiles = [
        networking.bbr
        networking.optimise
      ];
    }
  ];
}
