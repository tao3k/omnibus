let
  inherit (root.errors.requiredInputs inputs "omnibus.pops.self" [ "std" ]) std;
in
super.load {
  loader = with haumea; [ (matchers.nix loaders.scoped) ];
  src = projectDir + "/units/std";
  inputs.inputs = {
    inherit std;
  };
}
