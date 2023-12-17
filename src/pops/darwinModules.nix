# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  projectRoot,
  flops,
}:
super.nixosModules.addLoadExtender {
  load.src = projectRoot + "/units/nixos/darwinModules";
}
