# SPDX-FileCopyrightText: 2024 The divnix/hive Authors
#
# SPDX-License-Identifier: Unlicense

{
  lib,
  root,
  super,
}:
let
  inherit (lib) pipe;
  l = lib // builtins;
  inherit (root.hive) checks transformers;
in
super.walk transformers.darwinConfiguration [ (config: config.bee._evaled) ]
