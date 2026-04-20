# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
list:
let
  sources = (import ../../units/lock/flake.nix).inputs;
  /**
    Resolve only the requested lockfile inputs and preserve the caller's
    requested order so diagnostics stay aligned with the missing-input list.
  */
  toSource = name: {
    inherit name;
    url = sources.${name}.url;
  };
in
map toSource (lib.filter (name: lib.hasAttr name sources) list)
