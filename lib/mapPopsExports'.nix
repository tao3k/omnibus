{ lib }:
pops:
let
  cond = (as: !(as ? "exports" && as.exports ? "default"));
  pops' = if !cond pops then pops.exports else pops;
in
lib.mapAttrsRecursiveCond cond (_: v: v.exports) pops'
