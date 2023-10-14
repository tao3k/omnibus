{ lib }:
pops:
lib.mapAttrsRecursiveCond ((as: !(as ? "layouts" || as ? "outputs")))
  (_: v: v.layouts or v.outputs)
  pops
