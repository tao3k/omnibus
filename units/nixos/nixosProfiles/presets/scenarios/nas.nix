# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = true;
    "fs.inotify.max_user_watches" = "100000";
  };
}
