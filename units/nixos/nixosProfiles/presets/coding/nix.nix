# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  pkgs,
  omnibus,
  inputs,
}:
let
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.nixosProfiles" [
      "nil"
    ])
    nil
    ;
  pkgs' = pkgs.appendOverlays [ nil.overlays.default ];
in
{
  environment.systemPackages = [
    pkgs'.nil
    # pkgs.namaka
  ];
}
