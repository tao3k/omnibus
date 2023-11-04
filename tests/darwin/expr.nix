{
  super,
  trace,
  lib,
  root,
  omnibus,
}:
let
  out = root.nixos.pops.exports.default;
in
{
  darwinFontProfile =
    (out.layouts.darwinConfiguration [
      omnibus.darwinProfiles.presets.homebrew
      omnibus.darwinProfiles.presets.nix.default
      { homebrew.__profiles__.enableFonts = true; }
    ]).config.homebrew.casks;

  darwinNixProfile =
    (out.layouts.darwinConfiguration [ omnibus.darwinProfiles.presets.nix.default ])
    .config.nix.extraOptions;
}

// lib.optionalAttrs trace { }
