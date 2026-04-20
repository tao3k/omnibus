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
  nix-filter = root.pops.flake.inputs.nix-filter.lib;
  nix-std = root.pops.flake.inputs.nix-std.lib;
  omnibus = inputs.self;
}
