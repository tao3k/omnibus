{ lib }:
pops:
lib.mapAttrsRecursiveCond ((as: !(as ? "exports"))) (_: v: v.exports) pops
