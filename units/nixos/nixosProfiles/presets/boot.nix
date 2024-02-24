# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{ omnibus }:
{
  imports = [ omnibus.nixosModules.boot ];
  boot.__profiles__.systemd-boot.enable = true;
  boot.__profiles__.speedup = true;
}
