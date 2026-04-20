# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
let
  inherit (lib.types) suiteProfile;
  /**
    Suite profile attrsets contribute their `profiles` payload, while plain
    values pass through unchanged.
  */
  resolveProfile = value: if lib.isAttrs value then (suiteProfile value).profiles else value;
in
map resolveProfile
