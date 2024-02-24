# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ omnibus }:
let
  inherit (omnibus.flake.inputs) nixpkgs;
in
(omnibus.pops.allData.addLoadExtender {
  load = {
    src = ./__fixture;
    inputs = {
      inputs.nixpkgs = nixpkgs.legacyPackages.x86_64-linux;
    };
  };
}).exports.default
