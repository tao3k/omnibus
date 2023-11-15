{
  flops,
  haumea,
  root,
}:
let
  inherit (flops) recursiveMerge';
in
load:
(flops.haumea.pops.default.setInit (
  recursiveMerge' [
    {
      loader = with haumea; [
        (matchers.nix loaders.scoped)
        (matchers.nix loaders.default)
      ];
      inputs = root.lib.loaderInputs;
    }
    load
  ]
)).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports = {
          derivations = lib.attrsets.filterDerivations self.layouts.default;
        };
      }
    ))
  ]
