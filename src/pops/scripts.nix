# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  root,
  inputs,
  lib,
  haumea,
  projectRoot,
  POP,
}:
(super.load {
  src = projectRoot + "/units/scripts";
  inputsTransformer = [
    (
      x:
      let
        makes =
          (inputs.self.pops.self.addLoadExtender {
            load.inputs.inputs = {
              inherit nixpkgs makesSrc;
            };
          }).exports.default.ops.makes;
        inherit
          (root.errors.requiredInputs x.inputs "omnibus.pops.scripts" [ "nixpkgs" ])
          nixpkgs
          makesSrc
          ;
      in
      x
      // {
        inherit nixpkgs;
        writeShellApplication = root.ops.writeShellApplication { inherit nixpkgs; };
      }
      // lib.optionalAttrs (x.inputs ? climodSrc) {
        climod = nixpkgs.callPackage inputs.climodSrc { pkgs = nixpkgs; };
      }
      // lib.optionalAttrs (x.inputs ? makesSrc) (
        makes
        // {
          inputs = {
            inherit makes;
          };
        }
      )
    )
  ];

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
