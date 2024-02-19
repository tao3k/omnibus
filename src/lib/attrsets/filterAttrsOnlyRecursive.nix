# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib, super }:
pred: set:
lib.listToAttrs (
  lib.concatMap (
    name:
    let
      v = set.${name};
    in
    if pred name v then
      [
        (lib.nameValuePair name (
          if lib.isAttrs v && !lib.isDerivation v then
            super.filterAttrsOnlyRecursive pred v
          else
            v
        ))
      ]
    else
      [ ]
  ) (lib.attrNames set)
)
