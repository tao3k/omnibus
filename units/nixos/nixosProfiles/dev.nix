# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

# [[file:../../../docs/org/nixosProfiles.org::*coding][coding:1]]
{root, self}:
let
  presets = root.presets;
in
with presets; {
  minimal = [shell.default];

  default = [
    self.minimal
    self.mathematic
    coding.nickel
    coding.conf
    coding.bash
    coding.d2
    coding.nix
  ];

  coding = [
    self.default
    {
      config.omnibus.coding = {
        bash.enableLsp = true;
        nickel.enableLsp = true;
        typst.enableLsp = true;
        conf.enableLsp = true;
      };
    }
  ];

  mathematic = [coding.typst];
}
# coding:1 ends here
