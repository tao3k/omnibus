# SPDX-FileCopyrightText: 2023 The omnibus Authors
#
# SPDX-License-Identifier: MIT

{
  boot.kernelModules = ["tcp_bbr"];
  boot.kernel.sysctl = {
    # Bufferbloat mitigations + slight improvements in throughput and latency.
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
    # Fast Open is a TCP extension that reduces network latency by packing
    # data in the sender’s initial TCP SYN.
    # NOTE: Setting 3 = enable for both incoming and outgoing connections.
    "net.ipv4.tcp_fastopen" = 3;
  };
}
