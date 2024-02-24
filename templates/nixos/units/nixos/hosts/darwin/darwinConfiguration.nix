# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs,
  super,
  lib,
}:
let
  inherit (inputs) nixpkgs darwin;
in
darwin.lib.darwinSystem rec {
  system = super.layouts.system;
  pkgs = import nixpkgs { inherit system; };
  modules = lib.flatten [ super.layouts.darwinSuites ];
}
