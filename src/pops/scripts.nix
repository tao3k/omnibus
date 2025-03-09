# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
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
  flops,
}:
(super.load {
  src = projectRoot + "/units/scripts";
  inputsTransformer = [
    (
      self:
      let
        makes =
          (inputs.self.pops.self.addLoadExtender {
            load.inputs.inputs = {
              inherit nixpkgs makesSrc;
            };
          }).exports.default.ops.makes;
        inherit
          (root.errors.requiredInputsLazily self.inputs "omnibus.pops.scripts" [
            "nixpkgs"
            "makesSrc"
            "nuenv"
            "pogSrc"
          ])
          nixpkgs
          makesSrc
          nuenv
          pogSrc
          ;
      in
      lib.recursiveUpdate self (
        {
          inherit nixpkgs;
          writeShellApplication = root.ops.writeShellApplication { inherit nixpkgs; };
        }
        // lib.optionalAttrs (self.inputs ? pogSrc) {
          pog = import (pogSrc + "/pog") { pkgs = nixpkgs; };
        }
        // lib.optionalAttrs (self.inputs ? nuenv) {
          nuenv = nixpkgs.extend nuenv.overlays.nuenv;
        }
        // lib.optionalAttrs (self.inputs ? makesSrc) (
          makes
          // {
            inputs = {
              inherit makes;
            };
          }
        )
      )
    )
  ];
  loader = with haumea; [ (matchers.nix loaders.scoped) ];
  transformer = [ (_cursor: dir: if dir ? default then dir.default else dir) ];
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports = {
          apps = lib.mapAttrs (
            _: target:
            let
              inherit (lib) getName;
              programName = target.meta.mainProgram or (getName target);
            in
            {
              type = "app";
              program = "${target}/bin/${programName}";
            }
          ) self.layouts.default;
        };
      }
    ))
  ]

/*
  (matchers.regex "^(default)\\.(nix)" (
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
