{
  root,
  lib,
  super,
}:
load:
let
  inherit
    (root.errors.requiredInputs load.inputs.inputs "omnibus.pops.jupyenv" [
      "jupyenv"
      "nixpkgs"
    ])
    nixpkgs
    jupyenv
  ;
  inherit (jupyenv.lib.${nixpkgs.system}) mkJupyterlabNew mkJupyterlabEval;

  setJupyenvModule =
    module: mkJupyterlabEval { imports = lib.flatten [ module ]; };
in
(super.nixosProfiles.addLoadExtender {
  load = {
    inputs = {
      inherit setJupyenvModule mkJupyterlabNew mkJupyterlabEval;
    };
  };
}).addLoadExtender
  { inherit load; }
