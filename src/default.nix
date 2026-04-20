# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs }:
let
  inherit (inputs) flops self;
  inherit (flops.popflow)
    POP
    yants
    haumea
    nixlib
    ;
  commonInputs = {
    haumea = haumea.lib;
    inherit POP yants;
    flops = flops.lib;
    projectRoot = ../.;
    inputs = {
      inherit (inputs) self;
      inherit (flops.popflow) dmerge;
    };
  };
  selfLib =
    (flops.lib.haumea.pops.default.withInitLoad {
      src = ./lib;
      inputs = {
        lib = nixlib // builtins;
      }
      // commonInputs;
    }).exports.default;
in
flops.lib.haumea.pops.default.withInitLoad {
  src = ./.;
  transformer = [ flops.lib.haumea.removeTopDefault ];
  inputs = {
    lib = (nixlib.recursiveUpdate nixlib selfLib) // builtins;
  }
  // commonInputs;
}
