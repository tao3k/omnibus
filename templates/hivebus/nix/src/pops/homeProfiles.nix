# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

(omnibus.pops.homeProfiles.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/homeProfiles";
    inputs = {
      inputs = inputs;
    };
  };
})
