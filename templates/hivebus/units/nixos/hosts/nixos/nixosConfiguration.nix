# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

let
  inherit (inputs) nixpkgs;
in
nixpkgs.lib.nixosSystem rec {
  system = super.layouts.system;
  pkgs = import nixpkgs { inherit system; };
  modules = lib.flatten [ super.layouts.nixosSuites ];
}
