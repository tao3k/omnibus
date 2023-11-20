# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  inherit (inputs) nixpkgs darwin;
in
darwin.lib.darwinSystem rec {
  system = super.layouts.system;
  pkgs = import nixpkgs { inherit system; };
  modules = lib.flatten [ super.layouts.darwinSuites ];
}
