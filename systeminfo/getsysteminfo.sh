Function_GetSystemInfo() {
    clear
    echo -e "${Msg_Info}LemonBench Server Test Toolkit Build ${BuildTime}"
    echo -e "${Msg_Info}SystemInfo - Collecting System Information ..."
    Check_Virtwhat
    echo -e "${Msg_Info}Collecting CPU Info ..."
    SystemInfo_GetCPUInfo
    SystemInfo_GetLoadAverage
    SystemInfo_GetSystemBit
    SystemInfo_GetCPUStat
    echo -e "${Msg_Info}Collecting Memory Info ..."
    SystemInfo_GetMemInfo
    echo -e "${Msg_Info}Collecting Virtualization Info ..."
    SystemInfo_GetVirtType
    echo -e "${Msg_Info}Collecting System Info ..."
    SystemInfo_GetUptime
    SystemInfo_GetKernelVersion
    echo -e "${Msg_Info}Collecting OS Release Info ..."
    SystemInfo_GetOSRelease
    echo -e "${Msg_Info}Collecting Disk Info ..."
    SystemInfo_GetDiskStat
    echo -e "${Msg_Info}Collecting Network Info ..."
    SystemInfo_GetNetworkCCMethod
    SystemInfo_GetNetworkInfo
    echo -e "${Msg_Info}Starting Test ..."
    clear
}
