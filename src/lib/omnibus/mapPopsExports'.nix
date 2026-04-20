# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
pops:
let
  /**
    Recurse until we reach a pop node that exports a default surface.
  */
  shouldRecurse = attrSet: !(attrSet ? "exports" && attrSet.exports ? "default");
  /**
    This prime variant keeps the whole `exports` attrset, so root pops unwrap to
    `exports` instead of `exports.default`.
  */
  rootPops = if !shouldRecurse pops then pops.exports else pops;
in
lib.mapAttrsRecursiveCond shouldRecurse (_: value: value.exports) rootPops
