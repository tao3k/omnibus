# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ super, lib }:
super.filterAttrsOnlyRecursive (
  n: attrs: lib.isDerivation attrs || attrs.recurseForDerivations or false
)
