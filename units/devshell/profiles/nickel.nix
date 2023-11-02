{
  omnibus,
  inputs,
  config,
}:
let
  inherit
    (omnibus.lib.errors.requiredInputs inputs "omnibus.pops.devshellProfiles" [
      "nickel"
    ])
    nickel
  ;
in
{
  packages = [
    nickel.packages.default
    nickel.packages.lsp-nls
  ];
}
