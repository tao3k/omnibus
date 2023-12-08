{
  boot.kernel.sysctl = {
    "net.ipv4.tcp_mtu_probing" = 1;
    "net.ipv4.tcp_sack" = "1";
    "net.ipv4.tcp_keepalive_time" = "80";
    "net.ipv4.tcp_keepalive_intvl" = "10";
    "net.ipv4.tcp_keepalive_probes" = "6";
  };
}
