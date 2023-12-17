# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(omnibus.pops.nixosModules.addLoadExtender {
  load = {
    src = projectRoot + "/units/nixos/darwinProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
