# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  modules = super.nixosModules.addLoadExtender {
    load.src = projectDir + "/units/flake-parts/modules";
  };
  profiles = super.nixosProfiles.addLoadExtender {
    load = {
      src = projectDir + "/units/flake-parts/profiles";
    };
  };
}
