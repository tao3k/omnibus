# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ inputs, super }:
let
  inherit (inputs) std;
in
{ ... }@args:
std.growOn (super.mkContent args)
