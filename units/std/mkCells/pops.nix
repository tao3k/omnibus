{
  omnibus,
  super,
  lib,
  inputs,
}:
commonArgs: cells:
let
  inherit (omnibus.lib.omnibus) mapLoadToPops;
  outputs = mapLoadToPops (lib.removeAttrs super [ "pops" ]) (
    n: v: { load.inputs = lib.recursiveUpdate { inputs = inputs; } commonArgs; }
  );
  checkSrc = p: if builtins.pathExists p.src then true else false;
in
lib.mapAttrs
  (
    n: v:
    if (lib.hasAttr n outputs && checkSrc v) then
      outputs.${n}.addLoadExtender { load = v; }
    else
      { exports.default = { }; }
  )
  cells
