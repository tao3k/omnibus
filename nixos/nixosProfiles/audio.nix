let
  inherit (root) presets;
in
{
  default = with presets; [
    pipewire
    bluetooth
  ];
}
