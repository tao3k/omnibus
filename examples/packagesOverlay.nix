# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# [[file:../docs/org/pops-packages.org::*Example][Example:3]]
{ super, omnibus }:
let
  nixos-23_05 = omnibus.flake.inputs.nixos-23_05;
in
nixos-23_05.legacyPackages.x86_64-linux.appendOverlays [
  # super.packages.exports.overlays.composeOverlay
  super.packages.exports.overlays.default
  (final: prev: {
    python3Packages = prev.python3Packages.override (
      old: {
        overrides = prev.lib.composeExtensions (old.packageOverrides or (_: _: { })) (
          selfP: _: super.packages.exports.packages.py.packages selfP
        );
      }
    );
  })
]
# Example:3 ends here