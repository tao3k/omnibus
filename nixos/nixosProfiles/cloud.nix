# [[file:../../docs/org/nixosProfiles.org::*cloud][cloud:1]]
{ root }:
let
  presets = root.presets;
in
with presets; {
  default = [ {
    boot.cleanTmpDir = true;
    boot.tmp.cleanOnBoot = true;
    zramSwap.enable = true;
    documentation.enable = false;
  } ];

  contabo = [
    self.default
    contabo
  ];
}
# cloud:1 ends here
