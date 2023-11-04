{ omnibus, lib }:
let
  inherit (omnibus.flake.inputs) nixpkgs makes;
  omnibusLib =
    (omnibus.pops.lib.addLoadExtender {
      load = {
        inputs = {
          inputs = {
            nixpkgs = nixpkgs.legacyPackages.x86_64-linux;
            inherit makes;
          };
        };
      };
    }).exports.default;

  inherit (omnibusLib.makes) makeScript;
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
