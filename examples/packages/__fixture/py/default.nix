# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  python3Packages,
  python3,
  lib,
  __inputs__,
}:
let
  inherit (lib) makeScope;
  inherit (python3Packages) newScope;
  inherit (__inputs__) callPackagesWithOmnibus;
in
makeScope newScope (selfScope: callPackagesWithOmnibus selfScope ./.)
