{ omnibus, lib }:
let
  inherit (omnibus.flake.inputs) nixpkgs makes;
  omnibusLib =
    (omnibus.pops.self.addLoadExtender {
      load = {
        inputs = {
          inputs = {
            nixpkgs = nixpkgs.legacyPackages.x86_64-linux;
            inherit makes;
          };
        };
      };
    }).exports.default;

  inherit (omnibusLib.ops.makes) makeScript;
in
{
  scripts =
    (omnibusLib.pops.scripts.addLoadExtender {
      load = {
        src = ./__fixture;
      };
    }).exports.default;

  inherit makeScript;
}
