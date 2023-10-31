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
    nix.default
    { omnibus.bootstrap.default = true; }
  ];
  full = [
    self.default
    { omnibus.bootstrap.full = true; }
  ];
}
