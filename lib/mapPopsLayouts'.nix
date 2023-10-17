{ lib }:
pops:
lib.mapAttrsRecursiveCond ((as: !(as ? "layouts"))) (_: v: v.layouts or v) pops
