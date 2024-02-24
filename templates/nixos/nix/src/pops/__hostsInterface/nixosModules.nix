# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ root, inputs }:
_name:
(root.pops.nixosModules.addLoadExtender {
  load = {
    inputs = { };
  };
})
