{ omnibus }:
let
  inherit (omnibus.flake.inputs) nixpkgs;
  initConfigs =
    (omnibus.units.configs {
      inputs = {
        inputs = {
          nixpkgs = import nixpkgs { system = "aarch64-darwin"; };
        };
      };
    }).exports.default;
  lefthook = initConfigs.lefthook;
in
{
  inherit lefthook;
}
