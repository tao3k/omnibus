{
  root,
  self,
  super,
}:
let
  presets = super.presets;
in
with presets; {
  default = [
    bootstrap
    { omnibus.bootstrap.minimal = true; }
  ];
}
