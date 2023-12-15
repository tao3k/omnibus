# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib, super }:
attrs:
let
  fun = f: lib.mapAttrs (_: v: if lib.isList v then lib.flatten (f v) else v);
in
fun super.concatProfiles attrs // { meta = fun lib.id attrs; }
