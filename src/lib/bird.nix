# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ root, lib }:
let
  inherit (root.pops.flake.inputs) bird-nix-lib;
in
lib.extend (import (bird-nix-lib + "/lib"))
