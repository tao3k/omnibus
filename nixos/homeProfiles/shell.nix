let
  presets = root.presets;
in
{
  default = [
    presets.zoxide
    presets.fzf
    presets.direnv
  ];
}
