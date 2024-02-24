# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ super, projectRoot }:
super.nixosModules.addLoadExtender {
  load = {
    src = projectRoot + "/units/devshell/modules";
    type = "nixosModules";
  };
}
