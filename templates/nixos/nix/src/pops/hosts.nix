# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  lib,
  super,
  omnibus,
  projectRoot,
}:
let
  inherit (omnibus.lib.omnibus) mkHosts;
in
mkHosts {
  hostsDir = projectRoot + "/units/nixos/hosts";
  pops = super.hostsInterface;
}
