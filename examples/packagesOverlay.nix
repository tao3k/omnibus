# [[file:../docs/org/pops-packages.org::*Example][Example:3]]
{ super, omnibus }:
let
  nixos-23_05 = omnibus.flake.inputs.nixos-23_05;
in
nixos-23_05.legacyPackages.x86_64-linux.extend super.packages.exports.overlay
# Example:3 ends here
