# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, cell }:
let
  inherit (inputs) nixpkgs;
  __inputs__ = (inputs.repo.flake.setSystem nixpkgs.system).inputs;
in
{
  inherit __inputs__;
}
