# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ omnibus, inputs }:
let
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.devshellProfiles" [
      "nickel"
    ])
    nickel
    ;
in
{
  packages = [
    nickel.packages.default
    nickel.packages.lsp-nls
  ];
}
