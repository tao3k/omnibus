{
  pkgs,
  inputs,
  omnibus,
  lib,
  config,
}:
let
  inherit
    (omnibus.lib.errors.requiredInputs inputs "omnibus.pops.nixosProfiles" [
      "typst"
    ])
    typst
  ;
  pkgs' = pkgs.appendOverlays [ typst.overlays.default ];
  cfg = config.omnibus.coding.typst;
in
{
  imports = [ omnibus.nixosModules.omnibus.coding.typst ];
  environment.systemPackages =
    [ pkgs'.typst ]
    ++ lib.optionals cfg.lsp [ pkgs'.typst-lsp ];
}
