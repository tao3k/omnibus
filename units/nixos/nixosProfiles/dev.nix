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
    coding.conf
    coding.bash
    coding.d2
    coding.nix
  ];

  coding = [
    self.default
    {
      config.omnibus.coding = {
        bash.lsp = true;
        nickel.lsp = true;
        typst.lsp = true;
        conf.lsp = true;
      };
    }
  ];

  mathematic = [ coding.typst ];
}
# coding:1 ends here
