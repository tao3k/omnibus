# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, omnibus }:
let
  inherit
    (omnibus.errors.requiredInputs inputs "omnibus.pops.nixosProfiles" [
      "sops-nix"
    ])
    sops-nix
    ;
in
{
  imports = [ sops-nix.nixosModules.sops ];
}
