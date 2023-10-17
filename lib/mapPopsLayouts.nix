{ lib }:
pops:
lib.mapAttrsRecursiveCond ((as: !(as ? "layouts" && as.layouts ? "default")))
  (_: v: v.layouts.default or v)
  pops
