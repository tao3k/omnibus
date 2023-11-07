{
  omnibus,
  root,
  haumea,
}:
(omnibus.pops.load {
  src = ./__fixture;
  loader = with haumea; [ (matchers.nix loaders.scoped) ];
  inputs = {
    data = root.data;
    inputs = {
      inherit (omnibus.flake.inputs) darwin nixpkgs home-manager;
    };
  };
})
