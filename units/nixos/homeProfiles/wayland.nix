# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ root, lib }:
let
  presets = root.presets;
  inherit (lib.omnibus) mkSuites;
in
mkSuites {
  default = with presets; [
    {
      keywords = [ "screenshot" ];
      knowledges = [ "https://github.com/gabm/satty" ];
      profiles = [ satty ];
    }
  ];
}
