# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  root,
  lib,
  super,
  POP,
  flops,
  projectRoot,
}:
(super.nixosProfiles.addLoadExtender {
  load = {
    src = projectRoot + "/units/jupyenv";
    type = "nixosProfiles";
    inputsTransformer = [
      (
        self:
        self
        // rec {
          inherit
            (root.errors.requiredInputs self.inputs "omnibus.pops.jupyenv" [
              "jupyenv"
              "nixpkgs"
            ])
            nixpkgs
            jupyenv
            ;
          inherit (jupyenv.lib.${nixpkgs.system}) mkJupyterlabNew mkJupyterlabEval;
          setJupyenvModule =
            module: mkJupyterlabEval { imports = lib.flatten [ module ]; };
        }
      )
    ];
    inputs = {
      writeShellApplicationFn = root.ops.writeShellApplication;
    };
  };
}).addExporters
  [
    (POP.extendPop flops.haumea.pops.exporter (
      self: _super: {
        exports =
          let
            setJupyenvModule = self.layouts.self.load.inputs.setJupyenvModule;
          in
          {
            jupyenvEvalModules = lib.mapAttrsRecursive (
              _: v: setJupyenvModule v
            ) self.layouts.default;
            jupyenvEnv = lib.mapAttrsRecursive (
              _: v: (setJupyenvModule v).config.build
            ) self.layouts.default;
          };
      }
    ))
  ]
