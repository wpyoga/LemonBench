Function_ShowSystemInfo() {
    echo -e "\n ${Font_Yellow}-> System Information${Font_Suffix}\n"
    if [ "${Var_OSReleaseVersion_Codename}" != "" ]; then
        echo -e " ${Font_Yellow}OS Release:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_OSReleaseFullName}${Font_Suffix}"
    else
        echo -e " ${Font_Yellow}OS Release:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_OSReleaseFullName}${Font_Suffix}"
    fi
    if [ "${Flag_DymanicCPUFreqDetected}" = "1" ]; then
        echo -e " ${Font_Yellow}CPU Model:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_CPUModelName}${Font_Suffix}  ${Font_White}${LBench_Result_CPUFreqMinGHz}~${LBench_Result_CPUFreqMaxGHz}${Font_Suffix}${Font_SkyBlue} GHz${Font_Suffix}"
    elif [ "${Flag_DymanicCPUFreqDetected}" = "0" ]; then
        echo -e " ${Font_Yellow}CPU Model:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_CPUModelName}  ${LBench_Result_CPUFreqGHz} GHz${Font_Suffix}"
    fi
    if [ "${LBench_Result_CPUCacheSize}" != "" ]; then
        echo -e " ${Font_Yellow}CPU Cache Size:${Font_Suffix}\t${Font_SkyBlue}${LBench_Result_CPUCacheSize}${Font_Suffix}"
    else
        echo -e " ${Font_Yellow}CPU Cache Size:${Font_Suffix}\t${Font_SkyBlue}None${Font_Suffix}"
    fi
    # CPU数量 分支判断
    if [ "${LBench_Result_CPUIsPhysical}" = "1" ]; then
        # 如果只存在1个物理CPU (单路物理服务器)
        if [ "${LBench_Result_CPUPhysicalNumber}" -eq "1" ]; then
            echo -e " ${Font_Yellow}CPU Number:${Font_Suffix}\t\t${LBench_Result_CPUPhysicalNumber} ${Font_SkyBlue}Physical CPU${Font_Suffix}, ${LBench_Result_CPUCoreNumber} ${Font_SkyBlue}Cores${Font_Suffix}, ${LBench_Result_CPUThreadNumber} ${Font_SkyBlue}Threads${Font_Suffix}"
        # 存在多个CPU, 继续深入分析检测 (多路物理服务器)
        elif [ "${LBench_Result_CPUPhysicalNumber}" -ge "2" ]; then
            echo -e " ${Font_Yellow}CPU Number:${Font_Suffix}\t\t${LBench_Result_CPUPhysicalNumber} ${Font_SkyBlue}Physical CPU(s)${Font_Suffix}, ${LBench_Result_CPUCoreNumber} ${Font_SkyBlue}Cores/CPU${Font_Suffix}, ${LBench_Result_CPUSiblingsNumber} ${Font_SkyBlue}Threads/CPU${Font_Suffix} (Total ${Font_SkyBlue}${LBench_Result_CPUTotalCoreNumber}${Font_Suffix} Cores, ${Font_SkyBlue}${LBench_Result_CPUProcessorNumber}${Font_Suffix} Threads)"
        # 针对树莓派等特殊情况做出检测优化
        elif [ "${LBench_Result_CPUThreadNumber}" = "0" ] && [ "${LBench_Result_CPUProcessorNumber} " -ge "1" ]; then
             echo -e " ${Font_Yellow}CPU Number:${Font_Suffix}\t\t${LBench_Result_CPUProcessorNumber} ${Font_SkyBlue}Cores${Font_Suffix}"
        fi
        if [ "${LBench_Result_CPUVirtualization}" = "1" ]; then
            echo -e " ${Font_Yellow}VirtReady:${Font_Suffix}\t\t${Font_SkyBlue}Yes${Font_Suffix} ${Font_SkyBlue}(Based on${Font_Suffix} ${LBench_Result_CPUVirtualizationType}${Font_SkyBlue})${Font_Suffix}"
        else
            echo -e " ${Font_Yellow}VirtReady:${Font_Suffix}\t\t${Font_SkyRed}No${Font_Suffix}"
        fi
    elif [ "${Var_VirtType}" = "openvz" ]; then
        echo -e " ${Font_Yellow}CPU Number:${Font_Suffix}\t\t${LBench_Result_CPUThreadNumber} ${Font_SkyBlue}vCPU${Font_Suffix} (${LBench_Result_CPUCoreNumber} ${Font_SkyBlue}Host Core/Thread${Font_Suffix})"
    else
        if [ "${LBench_Result_CPUVirtualization}" = "2" ]; then
            echo -e " ${Font_Yellow}CPU Number:${Font_Suffix}\t\t${LBench_Result_CPUThreadNumber} ${Font_SkyBlue}vCPU${Font_Suffix}"
            echo -e " ${Font_Yellow}VirtReady:${Font_Suffix}\t\t${Font_SkyBlue}Yes${Font_Suffix} ${Font_SkyBlue}(Nested Virtualization)${Font_Suffix}"
        else
            echo -e " ${Font_Yellow}CPU Number:${Font_Suffix}\t\t${LBench_Result_CPUThreadNumber} ${Font_SkyBlue}vCPU${Font_Suffix}"
        fi
    fi
    echo -e " ${Font_Yellow}Virt Type:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_VirtType}${Font_Suffix}"
    # 内存使用率 分支判断
    if [ "${LBench_Result_MemoryUsed_KB}" -lt "1024" ] && [ "${LBench_Result_MemoryTotal_KB}" -lt "1048576" ]; then
        LBench_Result_Memory="${LBench_Result_MemoryUsed_KB} KB / ${LBench_Result_MemoryTotal_MB} MB"
        echo -e " ${Font_Yellow}Memory Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_MemoryUsed_MB} KB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_MemoryTotal_MB} MB${Font_Suffix}"
    elif [ "${LBench_Result_MemoryUsed_KB}" -lt "1048576" ] && [ "${LBench_Result_MemoryTotal_KB}" -lt "1048576" ]; then
        LBench_Result_Memory="${LBench_Result_MemoryUsed_MB} MB / ${LBench_Result_MemoryTotal_MB} MB"
        echo -e " ${Font_Yellow}Memory Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_MemoryUsed_MB} MB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_MemoryTotal_MB} MB${Font_Suffix}"
    elif [ "${LBench_Result_MemoryUsed_KB}" -lt "1048576" ] && [ "${LBench_Result_MemoryTotal_KB}" -lt "1073741824" ]; then
        LBench_Result_Memory="${LBench_Result_MemoryUsed_MB} MB / ${LBench_Result_MemoryTotal_GB} GB"
        echo -e " ${Font_Yellow}Memory Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_MemoryUsed_MB} MB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_MemoryTotal_GB} GB${Font_Suffix}"
    else
        LBench_Result_Memory="${LBench_Result_MemoryUsed_GB} GB / ${LBench_Result_MemoryTotal_GB} GB"
        echo -e " ${Font_Yellow}Memory Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_MemoryUsed_GB} GB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_MemoryTotal_GB} GB${Font_Suffix}"
    fi
    # Swap使用率 分支判断
    if [ "${LBench_Result_SwapTotal_KB}" -eq "0" ]; then
        LBench_Result_Swap="[ No Swapfile / Swap partition ]"
        echo -e " ${Font_Yellow}Swap Usage:${Font_Suffix}\t\t${Font_SkyBlue}[ No Swapfile/Swap Partition ]${Font_Suffix}"
    elif [ "${LBench_Result_SwapUsed_KB}" -lt "1024" ] && [ "${LBench_Result_SwapTotal_KB}" -lt "1048576" ]; then
        LBench_Result_Swap="${LBench_Result_SwapUsed_KB} KB / ${LBench_Result_SwapTotal_MB} MB"
        echo -e " ${Font_Yellow}Swap Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_SwapUsed_KB} KB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_SwapTotal_MB} MB${Font_Suffix}"
    elif [ "${LBench_Result_SwapUsed_KB}" -lt "1024" ] && [ "${LBench_Result_SwapTotal_KB}" -lt "1073741824" ]; then
        LBench_Result_Swap="${LBench_Result_SwapUsed_KB} KB / ${LBench_Result_SwapTotal_GB} GB"
        echo -e " ${Font_Yellow}Swap Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_SwapUsed_KB} KB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_SwapTotal_GB} GB${Font_Suffix}"
    elif [ "${LBench_Result_SwapUsed_KB}" -lt "1048576" ] && [ "${LBench_Result_SwapTotal_KB}" -lt "1048576" ]; then
        LBench_Result_Swap="${LBench_Result_SwapUsed_MB} MB / ${LBench_Result_SwapTotal_MB} MB"
        echo -e " ${Font_Yellow}Swap Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_SwapUsed_MB} MB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_SwapTotal_MB} MB${Font_Suffix}"
    elif [ "${LBench_Result_SwapUsed_KB}" -lt "1048576" ] && [ "${LBench_Result_SwapTotal_KB}" -lt "1073741824" ]; then
        LBench_Result_Swap="${LBench_Result_SwapUsed_MB} MB / ${LBench_Result_SwapTotal_GB} GB"
        echo -e " ${Font_Yellow}Swap Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_SwapUsed_MB} MB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_SwapTotal_GB} GB${Font_Suffix}"
    else
        LBench_Result_Swap="${LBench_Result_SwapUsed_GB} GB / ${LBench_Result_SwapTotal_GB} GB"
        echo -e " ${Font_Yellow}Swap Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_SwapUsed_GB} GB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_SwapTotal_GB} GB${Font_Suffix}"
    fi
    # 启动磁盘
    echo -e " ${Font_Yellow}Boot Device:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_DiskRootPath}${Font_Suffix}"
    # 磁盘使用率 分支判断
    if [ "${LBench_Result_DiskUsed_KB}" -lt "1000000" ]; then
        LBench_Result_Disk="${LBench_Result_DiskUsed_MB} MB / ${LBench_Result_DiskTotal_MB} MB"
        echo -e " ${Font_Yellow}Disk Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_DiskUsed_MB} MB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_DiskTotal_MB} MB${Font_Suffix}"
    elif [ "${LBench_Result_DiskUsed_KB}" -lt "1000000" ] && [ "${LBench_Result_DiskTotal_KB}" -lt "1000000000" ]; then
        LBench_Result_Disk="${LBench_Result_DiskUsed_MB} MB / ${LBench_Result_DiskTotal_GB} GB"
        echo -e " ${Font_Yellow}Disk Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_DiskUsed_MB} MB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_DiskTotal_GB} GB${Font_Suffix}"
    elif [ "${LBench_Result_DiskUsed_KB}" -lt "1000000000" ] && [ "${LBench_Result_DiskTotal_KB}" -lt "1000000000" ]; then
        LBench_Result_Disk="${LBench_Result_DiskUsed_GB} GB / ${LBench_Result_DiskTotal_GB} GB"
        echo -e " ${Font_Yellow}Disk Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_DiskUsed_GB} GB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_DiskTotal_GB} GB${Font_Suffix}"
    elif [ "${LBench_Result_DiskUsed_KB}" -lt "1000000000" ] && [ "${LBench_Result_DiskTotal_KB}" -ge "1000000000" ]; then
        LBench_Result_Disk="${LBench_Result_DiskUsed_GB} GB / ${LBench_Result_DiskTotal_TB} TB"
        echo -e " ${Font_Yellow}Disk Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_DiskUsed_GB} GB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_DiskTotal_TB} TB${Font_Suffix}"
    else
        LBench_Result_Disk="${LBench_Result_DiskUsed_TB} TB / ${LBench_Result_DiskTotal_TB} TB"
        echo -e " ${Font_Yellow}Disk Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_DiskUsed_TB} TB${Font_Suffix} / ${Font_SkyBlue}${LBench_Result_DiskTotal_TB} TB${Font_Suffix}"
    fi
    # CPU状态
    echo -e " ${Font_Yellow}CPU Usage:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_CPUStat_UsedAll}% used${Font_Suffix}, ${Font_SkyBlue}${LBench_Result_CPUStat_iowait}% iowait${Font_Suffix}, ${Font_SkyBlue}${LBench_Result_CPUStat_steal}% steal${Font_Suffix}"
    # 系统负载
    echo -e " ${Font_Yellow}Load (1/5/15min):${Font_Suffix}\t${Font_SkyBlue}${LBench_Result_LoadAverage_1min} ${LBench_Result_LoadAverage_5min} ${LBench_Result_LoadAverage_15min} ${Font_Suffix}"
    # 系统开机时间
    echo -e " ${Font_Yellow}Uptime:${Font_Suffix}\t\t${Font_SkyBlue}${LBench_Result_SystemInfo_Uptime_Day} Days, ${LBench_Result_SystemInfo_Uptime_Hour} Hours, ${LBench_Result_SystemInfo_Uptime_Minute} Minutes, ${LBench_Result_SystemInfo_Uptime_Second} Seconds${Font_Suffix}"
    # 内核版本
    echo -e " ${Font_Yellow}Kernel Version:${Font_Suffix}\t${Font_SkyBlue}${LBench_Result_KernelVersion}${Font_Suffix}"
    # 网络拥塞控制方式
    echo -e " ${Font_Yellow}Network CC Method:${Font_Suffix}\t${Font_SkyBlue}${LBench_Result_NetworkCCMethod}${Font_Suffix}"
    # 执行完成, 标记FLAG
    LBench_Flag_FinishSystemInfo="1"
}
