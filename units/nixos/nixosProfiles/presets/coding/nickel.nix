{
  pkgs,
  inputs,
  omnibus,
  config,
  lib,
}:
let
  inherit
    (omnibus.errors.requiredInputs inputs "omnibus.pops.nixosProfiles" [ "nickel" ])
    nickel
  ;
  cfg = config.omnibus.coding.nickel;
in
{
  imports = [ omnibus.nixosModules.omnibus.coding.nickel ];
  environment.systemPackages =
    [ (nickel.packages.${pkgs.system}.default or inputs.nickel.default) ]
    ++ lib.optionals cfg.lsp [
      (nickel.packages.${pkgs.system}.lsp-nls or inputs.nickel.lsp-nls)
    ];
}
