# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
pops:
let
  cond = (as: !(as ? "exports" && as.exports ? "default"));
  pops' = if !cond pops then pops.exports else pops;
in
lib.mapAttrsRecursiveCond cond (_: v: v.exports) pops'
