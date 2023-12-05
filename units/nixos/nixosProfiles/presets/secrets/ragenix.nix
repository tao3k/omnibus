# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{inputs, omnibus}:
let
  inherit
    (omnibus.errors.requiredInputs inputs "omnibus.pops.nixosProfiles" ["ragenix"])
    ragenix
    ;
in
{
  imports = [ragenix.nixosModules.age];
  age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  # age.secretsDir = "/run/keys";
}
