# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs,
  lib,
  root,
}:
let
  l = nixpkgs.lib // builtins;
  inherit
    (root.errors.requiredInputs inputs "omnibus.pops.self" [
      "nixpkgs"
      "makesSrc"
    ])
    nixpkgs
    makesSrc
    ;
in
l.fix (
  l.extends
    (_: _: {
      inherit inputs;
      inherit (nixpkgs) system;
      __nixpkgs__ = nixpkgs;
      __nixpkgsSrc__ = nixpkgs.path;
    })
    (import (makesSrc + /src/args/agnostic.nix) {inherit (nixpkgs) system;})
    .__unfix__
)
