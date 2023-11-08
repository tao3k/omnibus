{ inputs, omnibus }:
let
  inherit
    (omnibus.errors.requiredInputs inputs "omnibus.pops.nixosProfiles" [
      "ragenix"
    ])
    ragenix
  ;
in
{
  imports = [ ragenix.nixosModules.age ];
  # age.secretsDir = "/run/keys";
}
