{ lib }:
pops:
lib.mapAttrsRecursiveCond
  ((as: !(as ? "layouts" && as.layouts ? "default" || as ? "outputs")))
  (_: v: v.layouts.default or v.outputs)
  pops
