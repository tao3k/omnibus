{
  pkgs,
  inputs,
  omnibus,
}:
let
  inherit
    (omnibus.lib.errors.requiredInputs inputs "omnibus.pops.nixosProfiles" [
      "nickel"
    ])
    nickel
  ;
in
{
  environment.systemPackages = [
    (nickel.packages.${pkgs.system}.default or inputs.nickel.default)
    (nickel.packages.${pkgs.system}.lsp-nls or inputs.nickel.lsp-nls)
  ];
}
