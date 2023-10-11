{
  super,
  trace,
  lib,
  root,
  omnibus,
}:
let
  exporter = root.nixos.pops.layouts.default;
in
{
  darwinFontProfile =
    (exporter.layouts.darwinConfiguration [
      omnibus.darwinProfiles.presets.homebrew
      { homebrew.__profiles__.fonts = true; }
    ]).config.homebrew.casks;
}
// lib.optionalAttrs trace { }
