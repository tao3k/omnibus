# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  pkgs,
  inputs,
  omnibus,
  lib,
  config,
}:
let
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.nixosProfiles" [
      "typst"
    ])
    typst
    ;
  pkgs' = pkgs.appendOverlays [ typst.overlays.default ];
  cfg = config.omnibus.coding.typst;
in
{
  imports = [ omnibus.nixosModules.omnibus.coding.typst ];
  environment.systemPackages = [
    pkgs'.typst
  ] ++ lib.optionals cfg.enableLsp [ pkgs.typst-lsp ];
}
