# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib, super }:
pred: set:
let
  /**
    Filter the current attrset first, then recurse only into the surviving
    non-derivation attrsets. This keeps the recursive shape obvious and avoids
    rebuilding the attrset through `concatMap`.
  */
  filtered = lib.filterAttrs pred set;
in
lib.mapAttrs (
  _name: value:
  if lib.isAttrs value && !lib.isDerivation value then
    super.filterAttrsOnlyRecursive pred value
  else
    value
) filtered
