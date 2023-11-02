{ omnibus, lib }:
let
  inherit (omnibus.flake.inputs) nixpkgs makes;
  makesLib =
    (omnibus.pops.lib.addLoadExtender {
      load = {
        inputs = {
          inputs = {
            nixpkgs = nixpkgs.legacyPackages.x86_64-linux;
            inherit makes;
          };
        };
      };
    }).exports.default.makes;

  inherit (makesLib) makeScript;
in
{
  makeScript = makeScript;
}
