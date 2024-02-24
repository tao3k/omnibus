# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ root, self }:
let
  inherit (root) presets;
in
{
  default = with presets; [
    opengl
    fontconfig
  ];
  nvidia = with presets; [
    self.default
    gpu.nvidia
  ];
}
