let
  inherit (inputs) nixpkgs;
in
(super.load {
  inputs =
    {
      inherit nixpkgs;
      inherit (root) makes;
      inherit (root.makes) makeScript;
    }
    // lib.optionalAttrs (inputs ? climod) {
      climod = nixpkgs.callPackage inputs.climod { pkgs = nixpkgs; };
    };
  loader = with haumea; [ (matchers.nix loaders.scoped) ];
  transformer = [ (_cursor: dir: if dir ? default then dir.default else dir) ];
})
