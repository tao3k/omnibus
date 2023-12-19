# [[file:../docs/org/pops-packages.org::*Example][Example:3]]
{ super, omnibus }:
let
  nixos-23_11 = omnibus.flake.inputs.nixos-23_11;
in
nixos-23_11.legacyPackages.x86_64-linux.appendOverlays [
  super.packages.exports.overlays.composePackages
  # super.packages.exports.overlays.default
  (final: prev: {
    python3Packages = prev.python3Packages.override (
      old: {
        overrides = prev.lib.composeExtensions (old.overrides or (_: _: { })) (
          selfP: _:
          # can be either super.packages.exports.packages.py.packages selfP
          {
            a = "1";
          }
        );
      }
    );
  })
]
# Example:3 ends here
