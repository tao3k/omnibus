# SPDX-FileCopyrightText: 2024 The divnix/hive Authors
#
# SPDX-License-Identifier: Unlicense

{ lib, root }:
transformer: extraPipe: renamer: hosts: system:

let
  l = lib // builtins;
  inherit (l) pipe;
  inherit (root.hive) checks transformers;
  walk' = lib.mapAttrs (
    hostName: hostConfig:
    pipe hostConfig (
      l.optionals (hostConfig.meta ? ${renamer} || hostConfig ? ${renamer}) (
        [
          (hostConfig: hostConfig.meta.${renamer} or hostConfig.${renamer})
          checks.bee
          transformer
        ]
        ++ extraPipe
      )
      ++ l.optionals (!hostConfig.meta ? ${renamer} && !hostConfig ? ${renamer}) [
        (_: { })
      ]
    )
  ) hosts;
in
l.filterAttrs (_: c: c != { }) walk'
