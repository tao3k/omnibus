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

  flakeProfiles =
    (omnibus.pops.flake-parts.profiles.addLoadExtender {
      load = {
        inputs = {
          inputs = {
            inherit (flake.inputs) chinookDb;
          };
        };
      };
    }).exports.default.process-compose;

  mkFlake =
    flake.inputs.flake-parts.lib.mkFlake
      {
        inputs = flake.inputs // {
          # fake self argument to make sure that the flake is
          self = inputs.self;
        };
      }
      {
        systems = [ system ];
        imports = [ flake.inputs.process-compose-flake.flakeModule ];
        perSystem = { ... }: { imports = [ flakeProfiles.sqlite-example ]; };
      };
in
lib.mapAttrs (_: builtins.unsafeDiscardStringContext) {
  example = mkFlake.packages.${system}.sqlite-example;
}
