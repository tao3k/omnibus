# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
list:
let
  sources = (import ../../units/lock/flake.nix).inputs;
  listSources = map (x: {
    name = x;
    url = sources.${x}.url;
  }) (lib.attrNames sources);
in
lib.filter (pair: lib.elem pair.name list) listSources
