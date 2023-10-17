# [[file:../../../docs/org/nixosProfiles.org::*coding][coding:1]]
{ root, self }:
let
  presets = root.presets;
in
with presets; {
  minimal = [ shell.default ];
  default = [
    self.minimal
    self.mathematic
    coding.nickel
    coding.yaml
    coding.bash
    coding.d2
    coding.nix
  ];

  mathematic = [ coding.typst ];
}
# coding:1 ends here
