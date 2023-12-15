# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  pkgs,
  omnibus,
  inputs,
}:
let
  inherit
    (omnibus.errors.requiredInputs inputs "omnibus.pops.nixosProfiles" [ "nil" ])
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
