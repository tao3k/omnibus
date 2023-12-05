# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  # https://sourceware.org/lvm2/
  services.lvm = {
    dmeventd.enable = true;
    boot = {
      vdo.enable = true;
      thin.enable = true;
    };
  };
}
