# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  super,
  projectRoot,
  flops,
}:
{
  modules = super.nixosModules.addLoadExtender {
    load.src = projectRoot + "/units/flake-parts/modules";
  };
  profiles = super.nixosProfiles.addLoadExtender {
    load = {
      type = "nixosProfiles";
      src = projectRoot + "/units/flake-parts/profiles";
    };
  };
}
