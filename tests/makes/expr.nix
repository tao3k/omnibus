{ omnibus, lib }:
let
  inherit (omnibus.__inputs__) nixpkgs makes;
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
    }).layouts.default.makes;

  inherit (makesLib) makeScript;
in
{
  makeScript = makeScript;
}
