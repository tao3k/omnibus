{ super, root }:
load:
let
  inherit
    (root.errors.requiredInputs load.inputs "omnibus.pops.packages" [ "nixpkgs" ])
    nixpkgs
  ;
  inherit (nixpkgs) newScope;
  inherit (nixpkgs.lib) makeScope;
in
makeScope newScope (
  self:
  let
    inherit (self) callPackage;
  in
  ((super.load load).addLoadExtender {
    load.loader = _: path: callPackage path { };
  })
)
