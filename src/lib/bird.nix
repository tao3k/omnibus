{root, lib}:
let
  inherit (root.pops.flake.inputs) bird-nix-lib;
in
lib.extend (import (bird-nix-lib + "/lib"))
