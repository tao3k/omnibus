# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  inputs,
  root,
  lib,
}:
inputs.self.pops.self.load.inputs
// {
  omnibus =
    (lib.recursiveUpdate root { pops.self = inputs.self.pops.self; })
    // root.flakeOutputs;
}
