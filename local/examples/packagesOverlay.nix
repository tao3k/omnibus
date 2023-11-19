{ super, omnibus }:
let
  nixos-23_05 = omnibus.flake.inputs.nixos-23_05;
in
nixos-23_05.legacyPackages.x86_64-linux.extend super.packages.exports.overlay
