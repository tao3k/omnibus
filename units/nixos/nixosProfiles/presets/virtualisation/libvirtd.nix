# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  security.polkit.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = ["all"];
    qemu = {
      runAsRoot = false;
    };
  };
}
