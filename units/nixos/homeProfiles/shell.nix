# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT
# [[id:cbe34da3-ffbb-423c-aee4-d0cd71af51e4][shell:1]]
{
  root,
  self,
  lib,
  super,
  inputs,
  isLinux,
  isDarwin,
}:
let
  presets = root.presets;
in
with presets;
{
  minimal = [
    direnv
    git
  ];

  default = [
    self.minimal
    self.modernTools
    self.utils
    # ------------------------------
    zoxide
    atuin
    carapace
    fzf
    navi
    starship.default
    dircolors.default
    # ------------------------------
    zellij
  ];

  fileManager = [
    yazi
    broot
  ];

  full = [
    self.default
    # ------------------------------
    spell-check
    self.fileManager
    (lib.optionals isLinux presets.alacritty)
  ];

  modernTools = [
    pls
    (lib.attrValues super.modernTools)
    # eza
  ];

  utils = [
    {
      programs.btop.enable = true;
      programs.bat.enable = true;
      programs.jq.enable = true;
    }
  ];
}
# shell:1 ends here
