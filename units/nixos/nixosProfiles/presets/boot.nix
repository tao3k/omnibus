# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  imports = [omnibus.nixosModules.boot];
  boot.__profiles__.systemd-boot.enable = true;
  boot.__profiles__.speedup = true;
}
