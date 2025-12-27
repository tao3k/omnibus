# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ omnibus, system }:
let
  inherit (omnibus.flake.inputs) nixpkgs;
in
(omnibus.pops.data.addLoadExtender {
  load = {
    src = ./__fixture;
    inputs = {
      inputs.nixpkgs = nixpkgs.legacyPackages.${system};
    };
  };
}).exports.default
