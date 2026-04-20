# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  omnibus,
  POP,
  flops,
  lib,
}:
let
  inputs =
    let
      baseInputs = omnibus.pops.flake.withInitInputs ./__lock;
    in
    (
      (baseInputs.addInputsExtender (
        POP.extendPop flops.flake.pops.inputs (
          _self: _super: {
            inputs = baseInputs.inputs // {
              devshell = baseInputs.inputs.devshell.legacyPackages;
            };
          }
        )
      )).withSystem
      "x86_64-linux"
    ).inputs;

  devshellProfiles =
    (omnibus.pops.devshellProfiles.addLoadExtender {
      load.inputs = {
        inputs = {
          inherit (inputs) fenix nixpkgs;
        };
      };
    }).exports.default;

  shell = inputs.devshell.mkShell {
    name = "rust";
    imports = [ devshellProfiles.rust ];
  };
in
lib.mapAttrs (_: builtins.unsafeDiscardStringContext) { rust = shell; }
