{
  omnibus,
  super,
  lib,
  inputs,
}:
commonArgs: attrs:
let
  inherit (omnibus.lib.omnibus) mapLoadToPops;
  outputs = mapLoadToPops (lib.removeAttrs super [ "pops" ]) (
    n: v: { load.inputs = lib.recursiveUpdate { inputs = inputs; } commonArgs; }
  );
  checkSrc = p: if builtins.pathExists p.src then true else false;
  checkSrc' = p: if builtins.pathExists (p.src + ".nix") then true else false;
  base =
    lib.mapAttrs
      (
        n: v:
        if (lib.hasAttr n outputs && checkSrc v) then
          outputs.${n}.addLoadExtender { load = v; }
        else if (lib.hasAttr n super && checkSrc' v) then
          { exports.default = import (v.src + ".nix") commonArgs; }
        else
          { exports.default = { }; }
      )
      attrs;
in
base // lib.optionalAttrs (base ? pops) base.pops.exports.default
