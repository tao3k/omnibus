# [[file:../../../docs/org/homeProfiles.org::*shell][shell:1]]
{
  root,
  self,
  lib,
  inputs,
}:
let
  presets = root.presets;
  inherit (inputs) nixpkgs;
in
with presets; {
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
    fzf
    starship.default
    dircolors.default
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
    (lib.optionals nixpkgs.stdenv.isLinux presets.alacritty)
  ];

  modernTools = [
    pls
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
