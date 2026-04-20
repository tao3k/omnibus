# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib, super }:
attrs:
let
  /**
    Apply a list transformer to suite-like attrs and leave non-list metadata
    untouched.
  */
  mapSuiteLists =
    transform:
    lib.mapAttrs (_: value: if lib.isList value then lib.flatten (transform value) else value);
in
mapSuiteLists super.concatProfiles attrs // { meta = mapSuiteLists lib.id attrs; }
