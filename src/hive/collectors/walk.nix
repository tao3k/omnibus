# SPDX-FileCopyrightText: 2024 The divnix/hive Authors
#
# SPDX-License-Identifier: Unlicense

{ lib, root }:
transformer: extraPipe: renamer:
{
  hosts ? { },
  system ? "",
  inputs ? { },
}@a:
let
  l = lib // builtins;
  inherit (l) pipe;
  inherit (root.hive) checks transformers;
  walk' = lib.mapAttrs (
    hostName: hostConfig:
    pipe hostConfig (
      l.optionals
        (hostConfig ? ${renamer} || (hostConfig ? meta && hostConfig.meta ? ${renamer}))
        (
          [
            (hostConfig: hostConfig.${renamer} or hostConfig.meta.${renamer})
            checks.bee
            (c: c // { inherit inputs; })
            transformer
          ]
          ++ extraPipe
        )
      ++ l.optionals (
        !hostConfig ? ${renamer} && !(hostConfig ? meta && hostConfig.meta ? ${renamer})
      ) [ (_: { }) ]
    )
  ) hosts;
in
l.filterAttrs (_: c: c != { }) walk'
