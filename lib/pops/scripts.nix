(super.load {
  inputs = {
    inherit (inputs) nixpkgs;
    inherit (root.makes) makeScript;
  };
  loader = with haumea; [ (matchers.nix loaders.scoped) ];
  transformer = [ (_cursor: dir: if dir ? default then dir.default else dir) ];
})
