{ lib }:
pops: load:
lib.mapAttrsRecursiveCond ((as: !(as ? "addLoadExtender")))
  (n: v: v.addLoadExtender (load n v))
  pops
