SystemInfo_GetSystemBit() {
    local sysarch="$(uname -m)"
    if [ "${sysarch}" = "unknown" ] || [ "${sysarch}" = "" ]; then
        local sysarch="$(arch)"
    fi
    if [ "${sysarch}" = "x86_64" ]; then
        # X86平台 64位
        LBench_Result_SystemBit_Short="64"
        LBench_Result_SystemBit_Full="amd64"
    elif [ "${sysarch}" = "i386" ] || [ "${sysarch}" = "i686" ]; then
        # X86平台 32位
        LBench_Result_SystemBit_Short="32"
        LBench_Result_SystemBit_Full="i386"
    elif [ "${sysarch}" = "armv7l" ] || [ "${sysarch}" = "armv8" ] || [ "${sysarch}" = "armv8l" ] || [ "${sysarch}" = "aarch64" ]; then
        # ARM平台 暂且将32位/64位统一对待
        LBench_Result_SystemBit_Short="arm"
        LBench_Result_SystemBit_Full="arm"
    else
        LBench_Result_SystemBit_Short="unknown"
        LBench_Result_SystemBit_Full="unknown"                
    fi
}
