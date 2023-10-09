# [[file:../../docs/org/homeProfiles.org::*shell][shell:1]]
{ root }:
let
  presets = root.presets;
in
with presets; {
  default = [
    zoxide
    fzf
    direnv
    dircolors
  ];

  fileManager = [ yazi ];

  modernTools = [
    pls
    # eza
  ];
}
# shell:1 ends here
