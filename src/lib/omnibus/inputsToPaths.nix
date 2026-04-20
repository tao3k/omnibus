# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ lib, ... }:
inputs:
let
  /**
    Normalize nested store paths such as `/nix/store/.../share/doc` to the
    enclosing store root so callers get stable source roots back.
  */
  normalizeStorePath =
    pathValue:
    let
      pathString = toString pathValue;
      parts = lib.splitString "/" pathString;
      topLevelParts = lib.take 4 parts;
    in
    if lib.hasPrefix "/nix/store/" pathString then
      if lib.length parts > 4 then lib.concatStringsSep "/" topLevelParts else pathString
    else
      null;

  /**
    Walk flake-style inputs recursively and collect any `outPath`-like entries
    from both the current node and nested inputs.
  */
  collectPaths =
    node:
    if !lib.isAttrs node then
      [ ]
    else
      let
        currentPath =
          if node ? outPath then
            normalizeStorePath node.outPath
          else if node ? sourceInfo && node.sourceInfo ? outPath then
            normalizeStorePath node.sourceInfo.outPath
          else
            null;
      in
      lib.optional (currentPath != null) currentPath
      ++ lib.concatMap collectPaths (lib.attrValues (node.inputs or { }));
in
lib.unique (lib.concatMap collectPaths (lib.attrValues inputs))
