{ omnibus }:
let
  inherit (omnibus.__inputs__) nixpkgs;
  dataAll =
    (omnibus.pops.lib.addLoadExtender {
      load = {
        inputs = {
          inputs.nixpkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
      };
    }).layouts.default.exporter.pops.dataAll;
in
(dataAll.addLoadExtender {
  load = {
    src = ./__fixture;
  };
}).layouts.default
