# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{lib}:

let
  # Recursive function to collect all attribute values
  recursiveAttrValues =
    set:
    lib.flatten (
      lib.mapAttrsToList
        (
          _name: value:
          if lib.isAttrs value && !(lib.isFunction value) then
            recursiveAttrValues value
          else
            [value]
        )
        set
    );
in
recursiveAttrValues
