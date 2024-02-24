# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = projectRoot + "/units/nixos/darwinModules";
    inputs = {
      inputs = inputs;
    };
  };
})
