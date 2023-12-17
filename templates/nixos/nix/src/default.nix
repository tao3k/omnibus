# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, eachSystem }:
let
  inherit ((inputs.omnibus.pops.load { }).load.inputs) haumea;
  inherit (inputs.omnibus.lib.omnibus) cleanSourceTopDefault;
in
(inputs.omnibus.pops.load {
  src = cleanSourceTopDefault ./.;
  loader = with haumea; [ (matchers.nix loaders.scoped) ];
  inputs = {
    inherit inputs eachSystem;
    projectRoot = ../..;
  };
})
