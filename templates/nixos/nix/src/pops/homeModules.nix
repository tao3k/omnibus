# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(omnibus.pops.homeModules.addLoadExtender {
  load = {
    src = projectRoot + "/units/nixos/homeModules";
    inputs = {
      inputs = inputs;
    };
  };
})
