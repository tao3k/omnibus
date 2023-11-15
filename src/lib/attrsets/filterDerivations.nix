{ super, lib }:
super.filterAttrsOnlyRecursive (
  n: attrs: lib.isDerivation attrs || attrs.recurseForDerivations or false
)
