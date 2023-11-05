{
  flops,
  omnibus,
  haumea,
  root,
}:
load:
(flops.haumea.pops.default.setInit {
  loader = with haumea; [ (matchers.nix loaders.scoped) ];
  inputs = root.loaderInputs;
}).addLoadExtender
  { inherit load; }
