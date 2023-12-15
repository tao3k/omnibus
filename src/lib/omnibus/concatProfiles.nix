# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
let
  inherit (lib.types) suiteProfile;
  v = x: if lib.isAttrs x then (lib.types.suiteProfile x).profiles else x;
in
lib.concatMap (x: [ (v x) ])
