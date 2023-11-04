{
  flops,
  omnibus,
  haumea,
}:
load:
(flops.haumea.pops.default.setInit {
  loader = with haumea; [ (matchers.nix loaders.scoped) ];
  inputs = omnibus.pops.lib.load.inputs;
}).addLoadExtender
  { inherit load; }
