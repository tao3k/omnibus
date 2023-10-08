{ omnibus, inputs' }:
let
  loadDataAll =
    (omnibus.pops.lib.addLoadExtender {
      load = {
        inputs = {
          nixpkgs = inputs'.nixpkgs.legacyPackages.x86_64-linux;
        };
      };
    }).layouts.default.loadDataAll;
in
(loadDataAll.addLoadExtender {
  load = {
    src = ./__fixture;
  };
}).layouts.default
