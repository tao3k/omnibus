# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, omnibus }:
let
  inherit
    (omnibus.errors.requiredInputs inputs "omnibus.pops.nixosProfiles" [
      "impermanence"
    ])
    impermanence
    ;
in
{
  imports = [ impermanence.nixosModules.impermanence ];
  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist" = {
    directories = [
      "/var"
      "/root"
    ];
    files = [ "/etc/machine-id" ];
  };
}
