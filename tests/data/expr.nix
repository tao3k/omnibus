{ omnibus }:
let
  inherit (omnibus.flake.inputs) nixpkgs;
  allData =
    (omnibus.pops.lib.addLoadExtender {
      load = {
        inputs = {
          inputs.nixpkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
      };
    }).layouts.default.exporter.pops.allData;
in
(allData.addLoadExtender {
  load = {
    src = ./__fixture;
  };
}).layouts.default
