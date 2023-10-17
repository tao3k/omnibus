{ pkgs, omnibus }:
let
  inherit
    (omnibus.lib.errors.requiredInputs inputs "omnibus.pops.nixosProfiles" [
      "nil"
    ])
    nil
  ;
  pkgs' = pkgs.appendOverlays [ nil.overlays.default ];
in
{
  environment.systemPackages = [
    pkgs'.nil
    pkgs.namaka
  ];
}
