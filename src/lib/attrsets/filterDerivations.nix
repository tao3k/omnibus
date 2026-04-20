# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ super, lib }:
/**
  Keep derivations and attrsets explicitly marked with
  `recurseForDerivations = true`, recursively trimming everything else.
*/
super.filterAttrsOnlyRecursive (
  _name: value:
  lib.isDerivation value || (lib.isAttrs value && (value.recurseForDerivations or false))
)
