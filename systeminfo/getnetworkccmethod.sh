SystemInfo_GetNetworkCCMethod() {
    local val_cc="$(sysctl -n net.ipv4.tcp_congestion_control)"
    local val_qdisc="$(sysctl -n net.core.default_qdisc)"
    LBench_Result_NetworkCCMethod="${val_cc} + ${val_qdisc}"
}
