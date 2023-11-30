# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  imports = [inputs.self.nixosModules.boot];
  boot.__profiles__.test = "nixosProfiles.boot";
}
