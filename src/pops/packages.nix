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
  }).addExporters
    [
      (POP.extendPop flops.haumea.pops.exporter (
        self: _super: {
          exports = {
            overlay =
              selfPop: final: prev:
              (selfPop.addLoadExtender { load.inputs.inputs.nixpkgs = final; })
              .exports.default;
          };
        }
      ))
    ]
)
