{
  root,
  lib,
  super,
  POP,
  flops,
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
((super.nixosProfiles.addLoadExtender {
  load = {
    inputs = {
      inherit setJupyenvModule mkJupyterlabNew mkJupyterlabEval;
    };
  };
}).addLoadExtender
  { inherit load; }
).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: super: {
        exports = {
          jupyenvEvalModules =
            lib.mapAttrsRecursive (_: v: setJupyenvModule v)
              self.layouts.default;
          jupyenvEnv =
            lib.mapAttrsRecursive (_: v: (setJupyenvModule v).config.build)
              self.layouts.default;
        };
      }
    ))
  ]
