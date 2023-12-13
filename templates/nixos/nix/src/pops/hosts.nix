# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  lib,
  super,
  omnibus,
  projectDir,
}:
let
  inherit (omnibus.lib.omnibus) mkHosts;
in
mkHosts {
  hostsDir = projectDir + "/units/nixos/hosts";
  pops = super.hostsInterface;
}
