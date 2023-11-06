{ omnibus }:
let
  inherit (omnibus.flake.inputs) nixpkgs;
  allData =
    (omnibus.pops.self.addLoadExtender {
      load = {
        inputs = {
          inputs.nixpkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
      };
    }).exports.default.pops.allData;
in
(allData.addLoadExtender {
  load = {
    src = ./__fixture;
  };
}).exports.default
