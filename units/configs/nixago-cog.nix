{
  inputs,
  omnibus,
  lib,
}:
let
  inherit
    (omnibus.errors.requiredInputsLazily inputs "omnibus.pops.configs" [
      "nixpkgs"
    ])
    nixpkgs
    ;

in
{
  data = { };
  output = "cog.toml";
  packages = [ nixpkgs.cocogitto ];
  commands = [
    {
      package = nixpkgs.cocogitto;
      name = "cog";
    }
  ];
}
