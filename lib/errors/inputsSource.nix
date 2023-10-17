{ lib }:
list:
let
  sources = (import ../../local/lock/flake.nix).inputs;
  listSources =
    map
      (x: {
        name = x;
        url = sources.${x}.url;
      })
      (lib.attrNames sources);
in
lib.filter (pair: lib.elem pair.name list) listSources
