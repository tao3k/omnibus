{ omnibus }:
let
  inherit (omnibus.__inputs__) nixpkgs;
  loadDataAll =
    (omnibus.pops.lib.addLoadExtender {
      load = {
        inputs = {
          inputs.nixpkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
      };
    }).layouts.default.loadDataAll;
in
(loadDataAll.addLoadExtender {
  load = {
    src = ./__fixture;
  };
}).layouts.default
