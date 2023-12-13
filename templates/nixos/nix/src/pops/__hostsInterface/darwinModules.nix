# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{root, inputs}:
(root.pops.nixosModules.addLoadExtender {
  load = {
    inputs = {
      # only for host
      # custom = inputs.custom;
    };
  };
})
