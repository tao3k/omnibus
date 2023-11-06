{
  inputs,
  lib,
  root,
}:
let
  l = nixpkgs.lib // builtins;
  inherit
    (root.errors.requiredInputs inputs "lib" [
      "nixpkgs"
      "makes"
    ])
    nixpkgs
    makes
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
    (import (makes + /src/args/agnostic.nix) { inherit (nixpkgs) system; })
    .__unfix__
)
