# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  omnibus,
  lib,
  inputs,
}:
let
  system = "x86_64-linux";
  flake.inputs =
    ((omnibus.pops.flake.setInitInputs ./__lock).setSystem system).inputs;

  inherit
    ((omnibus.pops.microvms {
      src = ./__fixture;
      inputs = {
        inputs = {
          inherit (flake.inputs) nixpkgs microvm;
        };
      };
    }).exports
    )
    microvms
    default
  ;
in
lib.mapAttrs
  (_: v: if !lib.isFunction v then builtins.unsafeDiscardStringContext v else v)
  {
    exampleRunner = microvms.example.config.microvm.runner.qemu;
    exampleModule = default.example;
  }
