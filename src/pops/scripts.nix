let
  inherit (inputs) nixpkgs;
  inherit (root.ops) makes;
  inherit (makes) makeScript makeEnvVars;
in
(super.load {
  inputs =
    {
      inherit nixpkgs;
    }
    // lib.optionalAttrs (inputs ? climod) {
      climod = nixpkgs.callPackage inputs.climod { pkgs = nixpkgs; };
    }
    // lib.optionalAttrs (inputs ? makes) (
      makes
      // {
        inputs = {
          makesLib = makes;
        };
      }
    );

  loader = with haumea; [ (matchers.nix loaders.scoped) ];
  transformer = [ (_cursor: dir: if dir ? default then dir.default else dir) ];
})

/* (matchers.regex "^(default)\\.(nix)" (
            _: _: path:
            let
              getDir = (list: builtins.elemAt list ((builtins.length list) - 3)) (
                l.split "/" path
              );
            in
            (
              if l.hasPrefix "makes-" getDir then
                (scopedImport
                  (
                    self.load.inputs
                    // {
                      # inherit (self.initLoad.inputs.makes) makeEnvVars;
                      makeEnvVars = self: self;
                    }
                  )
                  path
                )
              else
                { }
            )
          ))
*/
