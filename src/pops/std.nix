# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  root,
  haumea,
  projectRoot,
  super,
}:
load:
let
  inherit
    (root.errors.requiredInputs load.inputs.inputs "omnibus.pops.std" [ "std" ])
    std
    ;
in
(super.load {
  loader = with haumea; [ (matchers.nix loaders.scoped) ];
  src = projectRoot + "/units/std";
  inputs.inputs = {
    inherit std;
  };
}).addLoadExtender
  { inherit load; }
