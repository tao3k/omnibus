# [[file:../../../docs/org/nixosProfiles.org::*hardware][hardware:1]]
{ root, self }:
let
  presets = root.presets;
in
with presets; {
  default = [
    audio.bluetooth
    audio.pipewire
  ];
}
# hardware:1 ends here
