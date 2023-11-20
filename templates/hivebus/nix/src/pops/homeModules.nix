# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(omnibus.pops.homeModules.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/homeModules";
    inputs = {
      inputs = inputs;
    };
  };
})
