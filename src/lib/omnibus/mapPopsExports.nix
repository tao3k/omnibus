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
  cond = (as: !(as ? "exports" && as.exports ? "default"));
  /**
    Root pops can already be wrapped in `exports.default`, so unwrap once before
    the recursive projection below.
  */
  pops' = if !cond pops then pops.exports.default else pops;
in
lib.mapAttrsRecursiveCond cond (_: v: v.exports.default or v) pops'
