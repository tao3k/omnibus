# SPDX-FileCopyrightText: 2024 The divnix/hive Authors
#
# SPDX-License-Identifier: Unlicense

{ lib, root }:
let
  l = lib // builtins;
  inherit (l) pipe;
  inherit (root.hive) checks transformers;
in
transformer: extraPipe: renamer: hosts:
lib.mapAttrs (
  hostName: hostConfig:
  pipe (hostConfig.meta.${renamer} or hostConfig.${renamer}) (
    [
      checks.bee
      transformer
    ]
    ++ extraPipe
  )
) hosts
