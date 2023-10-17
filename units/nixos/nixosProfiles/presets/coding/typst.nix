{
  pkgs,
  inputs,
  omnibus,
}:
let
  inherit
    (omnibus.lib.errors.requiredInputs inputs "omnibus.pops.nixosProfiles" [
      "typst"
    ])
    typst
  ;
  pkgs' = pkgs.appendOverlays [ typst.overlays.default ];
in
{
  environment.systemPackages = [
    pkgs'.typst-lsp
    pkgs'.typst
  ];
}
