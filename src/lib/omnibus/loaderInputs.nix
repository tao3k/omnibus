# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs,
  lib,
  haumea,
  POP,
  flops,
  yants,
  projectRoot,
  root,
  ...
}:
let
  /**
    Reuse the flake input set in one place so downstream helpers can pull
    shared libraries without repeating the long lookup chain.
  */
  flakeInputs = root.pops.flake.inputs;
in
{
  inherit
    lib
    haumea
    POP
    flops
    yants
    projectRoot
    inputs
    ;
  nix-filter = flakeInputs.nix-filter.lib;
  nix-std = flakeInputs.nix-std.lib;
  omnibus = inputs.self;
}
