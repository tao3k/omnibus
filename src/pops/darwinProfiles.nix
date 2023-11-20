# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  projectDir,
  flops,
}:
super.nixosProfiles.addLoadExtender {
  load = {
    src = projectDir + "/units/nixos/darwinProfiles";
  };
}
