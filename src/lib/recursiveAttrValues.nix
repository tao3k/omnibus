# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:

let
  /**
    Collect the leaf values of a nested attrset.

    Derivations are treated as leaves instead of descending into their large
    internal attribute sets, which keeps callers focused on the exported values
    they actually care about.
  */
  recursiveAttrValues =
    set:
    lib.mapAttrsToListRecursiveCond (_path: value: !(lib.isDerivation value)) (_path: value: value) set;
in
recursiveAttrValues
