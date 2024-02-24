# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
pops: load:
let
  # Condition to check if an attribute set contains 'addLoadExtender'
  hasAddLoadExtender =
    attrSet:
    (
      !(lib.isDerivation attrSet)
      && lib.isAttrs attrSet
      && attrSet ? "addLoadExtender"
    );

  # Function to process an attribute
  processAttr =
    n: v: if hasAddLoadExtender v then v.addLoadExtender (load n v) else v;
in

lib.mapAttrsRecursiveCond (as: !(hasAddLoadExtender as)) processAttr pops
