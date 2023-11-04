{
  omnibus,
  root,
  haumea,
}:
(omnibus.pops.load {
  src = ./__fixture;
  inputs = {
    data = root.data;
    inputs = {
      inherit (omnibus.flake.inputs) darwin nixpkgs home-manager;
    };
  };
})
