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
      omnibus.darwinProfiles.presets.nix.default
      { homebrew.__profiles__.fonts = true; }
    ]).config.homebrew.casks;

  darwinNixProfile =
    (exporter.layouts.darwinConfiguration [
      omnibus.darwinProfiles.presets.nix.default
    ]).config.nix.extraOptions;
}

// lib.optionalAttrs trace { }
