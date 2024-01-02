{
  omnibus,
  super,
  lib,
  inputs,
  haumea,
}:
{ inputs, cell }@commonArgs:
attrs:
let
  inherit (omnibus.lib.omnibus) mapLoadToPops;

  # Helper function to update load inputs
  updateLoadInputs = n: v: {
    load.inputs = lib.recursiveUpdate { inputs = inputs; } commonArgs;
  };

  # Generate outputs based on updated load inputs
  outputs = mapLoadToPops (lib.removeAttrs super [ "pops" ]) updateLoadInputs;

  # Check if the source path exists
  checkSrc = p: builtins.pathExists p.src;

  # Check if the source path with '.nix' extension exists
  checkSrcNix = p: builtins.pathExists (p.src + ".nix");

  # Assert and process each attribute
  processAttr =
    n: v:
    let
      assertMsg = !(checkSrc v && checkSrcNix v && commonArgs.inputs ? cellsFrom);
    in
    assert lib.assertMsg assertMsg "mkDefaultStd: Both ${n} and ${v.src}.nix exist. Since the loader has been embedded, Please remove one of them.";
    if lib.hasAttr n outputs && checkSrc v then
      outputs.${n}.addLoadExtender { load = v; }
    else if lib.hasAttr n super && checkSrcNix v then
      { exports.default = haumea.loaders.scoped commonArgs (v.src + ".nix"); }
    else
      { exports.default = { }; };

  # Processed base attributes
  base = lib.mapAttrs processAttr attrs;

  # Helper function to map load to pops
  mapLoadToPopsHelper =
    n: v:
    let
      firstKey = lib.head n;
    in
    {
      load =
        if lib.hasAttr firstKey base.pops.exports.default then
          base.pops.exports.default.${firstKey}
        else
          { };
    };
in
if base ? pops && base.pops.exports.default != { } then
  base.pops.exports.default // (mapLoadToPops base mapLoadToPopsHelper)
else
  base
