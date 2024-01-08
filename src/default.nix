# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs }:
let
  inherit (inputs) flops self;
  inherit (flops.inputs)
    POP
    yants
    haumea
    nixlib
    ;
in
flops.lib.haumea.pops.default.setInit {
  src = ./.;
  transformer = [ (import ./lib/haumea/removeTopDefault.nix { }) ];
  inputs = {
    lib = (nixlib.lib.recursiveUpdate nixlib.lib inputs.self.lib) // builtins;
    haumea = haumea.lib;
    POP = POP.lib;
    flops = flops.lib;
    inherit yants;
    projectRoot = ../.;
    inputs = {
      inherit (inputs) self;
      dmerge = flops.inputs.dmerge;
    };
  };
}
