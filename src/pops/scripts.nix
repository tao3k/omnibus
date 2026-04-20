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
let
  /**
    Script units also use nested `default.nix` entrypoints, so keep the
    existing flattening behavior while still centralizing the transformer.
  */
  flattenDefaultDir = _cursor: dir: if dir ? default then dir.default else dir;
in
(super.load {
  src = projectRoot + "/units/scripts";
  inputsTransformer = [
    (
      self:
      let
        /**
          Resolve optional script inputs lazily so we only force the branches
          that are actually requested by the current load.
        */
        requiredInputs = root.errors.requiredInputsLazily self.inputs "omnibus.pops.scripts" [
          "nixpkgs"
          "makesSrc"
          "nuenv"
          "pogSrc"
        ];
        nixpkgs = requiredInputs.nixpkgs;
      in
      lib.recursiveUpdate self (
        {
          inherit nixpkgs;
          writeShellApplication = root.ops.writeShellApplication { inherit nixpkgs; };
        }
        // lib.optionalAttrs (self.inputs ? pogSrc) {
          pog = import (requiredInputs.pogSrc + "/pog") { pkgs = nixpkgs; };
        }
        // lib.optionalAttrs (self.inputs ? nuenv) {
          nuenv = nixpkgs.extend requiredInputs.nuenv.overlays.nuenv;
        }
        // lib.optionalAttrs (self.inputs ? makesSrc) (
          let
            /**
              The makes pop needs a reduced input set rooted in the resolved
              `nixpkgs` and `makesSrc` for this script scope.
            */
            makes =
              (inputs.self.pops.self.addLoadExtender {
                load.inputs.inputs = {
                  inherit nixpkgs;
                  makesSrc = requiredInputs.makesSrc;
                };
              }).exports.default.ops.makes;
          in
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
  transformer = [ flattenDefaultDir ];
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
