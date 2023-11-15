{ super }:
super.filterAttrsOnlyRecursive (
  n: _: n != "recurseForDerivations" && n != "dimension"
)
