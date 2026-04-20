# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib, super }:
dir: pops: ext:
let
  list = lib.attrNames (lib.readDir dir);
  processPops =
    name:
    let
      /**
        Resolve the available pop directories for this host once and reuse them
        across every pop in the attrset.
      */
      dirs = lib.attrNames (lib.readDir (dir + "/${name}"));
    in
    lib.filterAttrs (_n: v: v != { }) (
      lib.mapAttrs (
        n: v:
        let
          src = dir + "/${name}/${n}";
        in
        if (v ? addLoadExtender && lib.elem n dirs) then
          if lib.isFunction ext then
            ext v
          else if lib.isAttrs ext then
            (v.addLoadExtender { load.src = src; }).addLoadExtender ext
          else
            v
        else
          { }
      ) pops
    );
in
lib.listToAttrs (
  map (name: {
    name = name;
    value = processPops name;
  }) list
)
