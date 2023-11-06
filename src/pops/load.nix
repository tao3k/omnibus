{
  flops,
  omnibus,
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
      loader = with haumea; [ (matchers.nix loaders.scoped) ];
      inputs = root.lib.loaderInputs;
    }
    load
  ]
))
