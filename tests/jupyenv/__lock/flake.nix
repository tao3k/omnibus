# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs = {
    nixpkgs.follows = "jupyenv/nixpkgs";
    jupyenv.url = "github:tweag/jupyenv?ref=refs/pull/524/head";
    jupyenv.inputs.flake-compat.follows = "";
  };
  outputs = _: {};
}
