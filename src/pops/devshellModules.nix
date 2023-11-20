# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

super.nixosModules.addLoadExtender {
  load = {
    src = projectDir + "/units/devshell/modules";
    type = "nixosModules";
  };
}
