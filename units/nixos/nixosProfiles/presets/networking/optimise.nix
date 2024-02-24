# SPDX-FileCopyrightText: 2023 The omnibus Authors
# SPDX-FileCopyrightText: 2024 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  boot.kernel.sysctl = {
    "net.ipv4.tcp_mtu_probing" = 1;
    "net.ipv4.tcp_sack" = "1";
    "net.ipv4.tcp_keepalive_time" = "80";
    "net.ipv4.tcp_keepalive_intvl" = "10";
    "net.ipv4.tcp_keepalive_probes" = "6";
  };
}
