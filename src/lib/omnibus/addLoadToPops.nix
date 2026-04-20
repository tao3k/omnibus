# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
list: pops: load:
let
  /**
    Extend every pop for a given host name, leaving values without
    `addLoadExtender` untouched.
  */
  extendPopsForHost =
    hostName:
    lib.mapAttrs (
      popName: value:
      if value ? addLoadExtender then value.addLoadExtender (load hostName popName value) else value
    ) pops;
in
lib.genAttrs list extendPopsForHost
