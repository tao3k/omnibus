# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, omnibus }:
let
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.nixosProfiles" [
      "ragenix"
    ])
    ragenix
    ;
in
{
  imports = [ ragenix.nixosModules.age ];
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  # age.secretsDir = "/run/keys";
}
