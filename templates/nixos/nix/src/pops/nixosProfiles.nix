# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(omnibus.pops.nixosProfiles.addLoadExtender {
  load = {
    src = projectRoot + "/units/nixos/nixosProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
