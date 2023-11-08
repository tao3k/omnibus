{
  root,
  haumea,
  projectDir,
}:
load:
let
  inherit
    (root.errors.requiredInputs load.inputs.inputs "omnibus.pops.std" [ "std" ])
    std
  ;
in
(super.load {
  loader = with haumea; [ (matchers.nix loaders.scoped) ];
  src = projectDir + "/units/std";
  inpputs.inputs = {
    inherit std;
  };
}).addLoadExtender
  { inherit load; }
