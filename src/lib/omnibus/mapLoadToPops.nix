# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib }:
pops: load:
let
  /**
    Detect pop nodes that can absorb an additional load extender.
  */
  hasAddLoadExtender =
    attrSet: lib.isAttrs attrSet && !(lib.isDerivation attrSet) && attrSet ? "addLoadExtender";

  /**
    Recurse only into ordinary attrsets. Derivations are treated as leaves so
    mapping a pop tree does not traverse large package metadata.
  */
  shouldRecurse =
    attrSet: lib.isAttrs attrSet && !(lib.isDerivation attrSet) && !(hasAddLoadExtender attrSet);

  /**
    Apply the caller-provided load extender whenever a pop exposes
    `addLoadExtender`.
  */
  processAttr =
    path: value: if hasAddLoadExtender value then value.addLoadExtender (load path value) else value;
in
lib.mapAttrsRecursiveCond shouldRecurse processAttr pops
