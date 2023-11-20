# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  projectDir,
  flops,
}:
super.nixosModules.addLoadExtender {
  load.src = projectDir + "/units/nixos/darwinModules";
}
