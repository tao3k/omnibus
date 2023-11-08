{ inputs, omnibus }:
let
  inherit
    (omnibus.errors.requiredInputs inputs "omnibus.pops.nixosProfiles" [
      "sops-nix"
    ])
    sops-nix
  ;
in
{
  imports = [ sops-nix.nixosModules.sops ];
}
