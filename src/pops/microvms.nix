# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  root,
  haumea,
  inputs,
  super,
  POP,
  flops,
  lib,
}:
load:
let
  inherit
    (root.errors.requiredInputs load.inputs.inputs "omnibus.pops.microvms" [
      "nixpkgs"
      "microvm"
    ])
    nixpkgs
    microvm
    ;
  inherit
    ((inputs.self.pops.self.addLoadExtender {
      load = {
        inputs.inputs = {
          inherit microvm nixpkgs;
        };
      };
    }).exports.default.ops
    )
    mkMicrovm
    ;
in
(super.flake-parts.profiles.addLoadExtender { inherit load; }).addExporters [
  (POP.extendPop flops.haumea.pops.exporter (
    self: _super: {
      exports = {
        microvms =
          lib.mapAttrsRecursiveCond (as: !(lib.isFunction as)) (_: v: mkMicrovm v)
            self.layouts.default;
      };
    }
  ))
]
