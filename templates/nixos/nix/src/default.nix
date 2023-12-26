# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, eachSystem }:
let
  inherit ((inputs.omnibus.pops.load { }).load.inputs) haumea;
  inherit (inputs.omnibus.lib.haumea) removeTopDefault;
in
(inputs.omnibus.pops.load {
  src = ./.;
  transformer = [ removeTopDefault ];
  loader = with haumea; [ (matchers.nix loaders.scoped) ];
  inputs = {
    inherit inputs eachSystem;
    projectRoot = ../..;
  };
})
