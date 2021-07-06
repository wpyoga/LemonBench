# 生成结果文件
Function_GenerateResult() {
    echo -e "${Msg_Info}Please wait, collecting results ..."
    mkdir -p /tmp/ >/dev/null 2>&1
    mkdir -p ${WorkDir}/result >/dev/null 2>&1
    Function_GenerateResult_Header >/dev/null
    Function_GenerateResult_SystemInfo >/dev/null
    Function_GenerateResult_NetworkInfo >/dev/null
    Function_GenerateResult_MediaUnlockTest >/dev/null
    Function_GenerateResult_SysBench_CPUTest >/dev/null
    Function_GenerateResult_SysBench_MemoryTest >/dev/null
    Function_GenerateResult_DiskTest >/dev/null
    Function_GenerateResult_Speedtest >/dev/null
    Function_GenerateResult_BestTrace >/dev/null
    Function_GenerateResult_Spoofer >/dev/null
    Function_GenerateResult_Footer >/dev/null
    echo -e "${Msg_Info}Generating Report ..."
    local finalresultfile="${WorkDir}/result/finalresult.txt"
    sleep 0.2
    if [ -f "${WorkDir}/result/00-header.result" ]; then
        cat ${WorkDir}/result/00-header.result >>${WorkDir}/result/finalresult.txt
    fi
    sleep 0.2
    if [ -f "${WorkDir}/result/01-systeminfo.result" ]; then
        cat ${WorkDir}/result/01-systeminfo.result >>${WorkDir}/result/finalresult.txt
    fi
    sleep 0.2
    if [ -f "${WorkDir}/result/02-networkinfo.result" ]; then
        cat ${WorkDir}/result/02-networkinfo.result >>${WorkDir}/result/finalresult.txt
    fi
    if [ -f "${WorkDir}/result/03-mediaunlocktest.result" ]; then
        cat ${WorkDir}/result/03-mediaunlocktest.result >>${WorkDir}/result/finalresult.txt
    fi
    sleep 0.2
    if [ -f "${WorkDir}/result/04-cputest.result" ]; then
        cat ${WorkDir}/result/04-cputest.result >>${WorkDir}/result/finalresult.txt
    fi
    sleep 0.2
    if [ -f "${WorkDir}/result/05-memorytest.result" ]; then
        cat ${WorkDir}/result/05-memorytest.result >>${WorkDir}/result/finalresult.txt
    fi
    sleep 0.2
    if [ -f "${WorkDir}/result/06-disktest.result" ]; then
        cat ${WorkDir}/result/06-disktest.result >>${WorkDir}/result/finalresult.txt
    fi
    if [ -f "${WorkDir}/result/07-speedtest.result" ]; then
        cat ${WorkDir}/result/07-speedtest.result >>${WorkDir}/result/finalresult.txt
    fi
    sleep 0.2
    if [ -f "${WorkDir}/result/08-besttrace.result" ]; then
        cat ${WorkDir}/result/08-besttrace.result >>${WorkDir}/result/finalresult.txt
    fi
    sleep 0.2
    if [ -f "${WorkDir}/result/09-spoofer.result" ]; then
        cat ${WorkDir}/result/09-spoofer.result >>${WorkDir}/result/finalresult.txt
    fi
    sleep 0.2
    if [ -f "${WorkDir}/result/99-footer.result" ]; then
        cat ${WorkDir}/result/99-footer.result >>${WorkDir}/result/finalresult.txt
    fi
    sleep 0.2
    echo -e "${Msg_Info}Saving local Report ..."
    cp ${WorkDir}/result/finalresult.txt $HOME/LemonBench.Result.txt
    sleep 0.1
    echo -e "${Msg_Info}Generating Report URL ..."
    cat ${WorkDir}/result/finalresult.txt | PasteBin_Upload
}

Function_GenerateResult_Header() {
    sleep 0.1
    local rfile="${WorkDir}/result/00-header.result"
    echo -e " " >>$rfile
    echo -e " LemonBench Linux System Benchmark Utility Version ${BuildTime} " >>$rfile
    echo -e " " >>$rfile
    echo -e " Bench Start Time:\t${LBench_Result_BenchStartTime}" >>$rfile
    echo -e " Bench Finish Time:\t${LBench_Result_BenchFinishTime}" >>$rfile
    echo -e " Test Mode:\t\t${Global_TestModeTips}" >>$rfile
    echo -e " \n\n"
}

Function_GenerateResult_SystemInfo() {
    sleep 0.1
    local rfile="${WorkDir}/result/01-systeminfo.result"
    if [ "${LBench_Flag_FinishSystemInfo}" = "1" ]; then
        echo -e " \n -> System Information" >>$rfile
        echo -e " " >>$rfile
        echo -e " OS Release:\t\t${LBench_Result_OSReleaseFullName}" >>$rfile
        if [ "${Flag_DymanicCPUFreqDetected}" = "1" ]; then
            echo -e " CPU Model:\t\t${LBench_Result_CPUModelName}  ${LBench_Result_CPUFreqMinGHz}~${LBench_Result_CPUFreqMaxGHz} GHz" >>$rfile
        elif [ "${Flag_DymanicCPUFreqDetected}" = "0" ]; then
            echo -e " CPU Model:\t\t${LBench_Result_CPUModelName}  ${LBench_Result_CPUFreqGHz} GHz" >>$rfile
        fi
        echo -e " CPU Cache Size:\t${LBench_Result_CPUCacheSize}" >>$rfile
        if [ "${LBench_Result_CPUIsPhysical}" = "1" ]; then
            if [ "${LBench_Result_CPUPhysicalNumber}" -eq "1" ]; then
                echo -e " CPU Number:\t\t${LBench_Result_CPUPhysicalNumber} Physical CPU, ${LBench_Result_CPUCoreNumber} Cores, ${LBench_Result_CPUThreadNumber} Threads" >>$rfile
            elif [ "${LBench_Result_CPUPhysicalNumber}" -ge "2" ]; then
                echo -e " CPU Number:\t\t${LBench_Result_CPUPhysicalNumber} Physical CPUs, ${LBench_Result_CPUCoreNumber} Cores/CPU, ${LBench_Result_CPUSiblingsNumber} Thread)/CPU (Total ${LBench_Result_CPUTotalCoreNumber} Cores, ${LBench_Result_CPUProcessorNumber} Threads)" >>$rfile
            elif [ "${LBench_Result_CPUThreadNumber}" = "0" ] && [ "${LBench_Result_CPUProcessorNumber} " -ge "1" ]; then
                echo -e " CPU Number:\t\t${LBench_Result_CPUProcessorNumber} Cores" >>$rfile
            fi
            if [ "${LBench_Result_CPUVirtualization}" = "1" ]; then
                echo -e " VirtReady:\t\tYes (Based on ${LBench_Result_CPUVirtualizationType})" >>$rfile
            elif [ "${LBench_Result_CPUVirtualization}" = "2" ]; then
                echo -e " VirtReady:\t\tYes (Nested Virtualization)" >>$rfile
            else
                echo -e " VirtReady:\t\t${Font_SkyRed}No" >>$rfile
            fi
        elif [ "${Var_VirtType}" = "openvz" ]; then
            echo -e " CPU Number:\t\t${LBench_Result_CPUThreadNumber} vCPU (${LBench_Result_CPUCoreNumber} Host Core(s)/Thread(s))" >>$rfile
        else
            echo -e " CPU Number:\t\t${LBench_Result_CPUThreadNumber} vCPU" >>$rfile
        fi
        echo -e " Virt Type:\t\t${LBench_Result_VirtType}" >>$rfile
        echo -e " Memory Usage:\t\t${LBench_Result_Memory}" >>$rfile
        echo -e " Swap Usage:\t\t${LBench_Result_Swap}" >>$rfile
        if [ "${LBench_Result_DiskUsed_KB}" -lt "1000000" ]; then
            LBench_Result_Disk="${LBench_Result_DiskUsed_MB} MB / ${LBench_Result_DiskTotal_MB} MB"
            echo -e " Disk Usage:\t\t${LBench_Result_DiskUsed_MB} MB / ${LBench_Result_DiskTotal_MB} MB" >>$rfile
        elif [ "${LBench_Result_DiskUsed_KB}" -lt "1000000" ] && [ "${LBench_Result_DiskTotal_KB}" -lt "1000000000" ]; then
            LBench_Result_Disk="${LBench_Result_DiskUsed_MB} MB / ${LBench_Result_DiskTotal_GB} GB"
            echo -e " Disk Usage:\t\t${LBench_Result_DiskUsed_MB} MB / ${LBench_Result_DiskTotal_GB} GB" >>$rfile
        elif [ "${LBench_Result_DiskUsed_KB}" -lt "1000000000" ] && [ "${LBench_Result_DiskTotal_KB}" -lt "1000000000" ]; then
            LBench_Result_Disk="${LBench_Result_DiskUsed_GB} GB / ${LBench_Result_DiskTotal_GB} GB"
            echo -e " Disk Usage:\t\t${LBench_Result_DiskUsed_GB} GB / ${LBench_Result_DiskTotal_GB} GB" >>$rfile
        elif [ "${LBench_Result_DiskUsed_KB}" -lt "1000000000" ] && [ "${LBench_Result_DiskTotal_KB}" -ge "1000000000" ]; then
            LBench_Result_Disk="${LBench_Result_DiskUsed_GB} GB / ${LBench_Result_DiskTotal_TB} TB"
            echo -e " Disk Usage:\t\t${LBench_Result_DiskUsed_GB} GB / ${LBench_Result_DiskTotal_TB} TB" >>$rfile
        else
            LBench_Result_Disk="${LBench_Result_DiskUsed_TB} TB / ${LBench_Result_DiskTotal_TB} TB"
            echo -e " Disk Usage:\t\t${LBench_Result_DiskUsed_TB} TB / ${LBench_Result_DiskTotal_TB} TB" >>$rfile
        fi
        echo -e " Boot Device:\t\t${LBench_Result_DiskRootPath}" >>$rfile
        echo -e " Load (1/5/15min):\t${LBench_Result_LoadAverage_1min} ${LBench_Result_LoadAverage_5min} ${LBench_Result_LoadAverage_15min} " >>$rfile
        echo -e " CPU Usage:\t\t${LBench_Result_CPUStat_UsedAll}% used, ${LBench_Result_CPUStat_iowait}% iowait, ${LBench_Result_CPUStat_steal}% steal" >>$rfile
        echo -e " Kernel Version:\t${LBench_Result_KernelVersion}" >>$rfile
        echo -e " Network CC Method:\t${LBench_Result_NetworkCCMethod}" >>$rfile
    fi
}

Function_GenerateResult_NetworkInfo() {
    sleep 0.1
    if [ "${LBench_Flag_FinishNetworkInfo}" = "1" ]; then
        local rfile="${WorkDir}/result/02-networkinfo.result"
        echo -e "\n -> Network Information\n" >>$rfile
        if [ "${LBench_Result_NetworkStat}" = "ipv4only" ] || [ "${LBench_Result_NetworkStat}" = "dualstack" ]; then
            if [ "${IPAPI_IPV4_ip}" != "" ]; then
                local IPAPI_IPV4_ip_masked="$(echo ${IPAPI_IPV4_ip} | awk -F'.' '{print $1"."$2."."$3".*"}')"
                echo -e " IPV4 - IP Address:\t[${IPAPI_IPV4_country_code}] ${IPAPI_IPV4_ip_masked}" >>$rfile
                echo -e " IPV4 - ASN Info:\t${IPAPI_IPV4_asn} (${IPAPI_IPV4_organization})" >>$rfile
                echo -e " IPV4 - Region:\t\t${IPAPI_IPV4_location}" >>$rfile
            else
                echo -e " IPV6 - IP Address:\tError: API Query Failed" >>$rfile
            fi
        fi
        if [ "${LBench_Result_NetworkStat}" = "ipv6only" ] || [ "${LBench_Result_NetworkStat}" = "dualstack" ]; then
            if [ "${IPAPI_IPV6_ip}" != "" ]; then
                local IPAPI_IPV6_IP_Masked="$(echo ${IPAPI_IPV6_ip} | sed "s/[0-9a-f]\{1,4\}.$/*/g")"
                echo -e " IPV6 - IP Address:\t[${IPAPI_IPV6_country_code}] ${IPAPI_IPV6_IP_Masked}" >>$rfile
                echo -e " IPV6 - ASN Info:\t${IPAPI_IPV6_asn} (${IPAPI_IPV6_organization})" >>$rfile
                echo -e " IPV6 - Region:\t\t${IPAPI_IPV6_location}" >>$rfile
            else
                echo -e " IPV6 - IP Address:\tError: API Query Failed" >>$rfile
            fi
        fi
    fi
}

Function_GenerateResult_MediaUnlockTest() {
    sleep 0.1
    if [ "${LBench_Flag_FinishMediaUnlockTest}" = "1" ]; then
        local rfile="${WorkDir}/result/03-mediaunlocktest.result"
        echo -e "\n -> Media Unlock Test\n" >>$rfile
        # HBO Now
        echo -e " HBO Now:\t\t\t\t${LemonBench_Result_MediaUnlockTest_HBONow}" >>$rfile
        # 动画疯
        echo -e " Bahamut Anime:\t\t\t\t${LemonBench_Result_MediaUnlockTest_BahamutAnime}" >>$rfile
        # Abema.TV
        echo -e " Abema.TV:\t\t\t\t${LemonBench_Result_MediaUnlockTest_AbemaTV_IPTest}" >>$rfile
        # Princess Connect Re:Dive 日服
        echo -e " Princess Connect Re:Dive Japan:\t${LemonBench_Result_MediaUnlockTest_PCRJP}" >>$rfile
        # 爱奇艺台湾站
        # echo -e " IQiYi Taiwan (Beta):\t\t\t${LemonBench_Result_MediaUnlockTest_IQiYi_Taiwan}" >>$rfile
        # BBC
        echo -e " BBC:\t\t\t\t\t${LemonBench_Result_MediaUnlockTest_BBC}" >>$rfile
        # 哔哩哔哩大陆限定
        echo -e " Bilibili China Mainland Only:\t\t${LemonBench_Result_MediaUnlockTest_ChinaMainland}" >>$rfile
        # 哔哩哔哩港澳台
        echo -e " Bilibili Hongkong/Macau/Taiwan:\t${LemonBench_Result_MediaUnlockTest_BilibiliHKMCTW}" >>$rfile
        # 哔哩哔哩台湾限定
        echo -e " Bilibili Taiwan Only:\t\t\t${LemonBench_Result_MediaUnlockTest_BilibiliTW}" >>$rfile
    fi
}

Function_GenerateResult_SysBench_CPUTest() {
    sleep 0.1
    if [ -f "${WorkDir}/SysBench/CPU/result.txt" ]; then
        cp -f ${WorkDir}/SysBench/CPU/result.txt ${WorkDir}/result/04-cputest.result
    fi
}

Function_GenerateResult_SysBench_MemoryTest() {
    sleep 0.1
    if [ -f "${WorkDir}/SysBench/Memory/result.txt" ]; then
        cp -f ${WorkDir}/SysBench/Memory/result.txt ${WorkDir}/result/05-memorytest.result
    fi
}

Function_GenerateResult_DiskTest() {
    sleep 0.1
    if [ -f "${WorkDir}/DiskTest/result.txt" ]; then
        cp -f ${WorkDir}/DiskTest/result.txt ${WorkDir}/result/06-disktest.result
    fi
}

Function_GenerateResult_Speedtest() {
    sleep 0.1
    if [ -f "${WorkDir}/Speedtest/result.txt" ]; then
        cp -f ${WorkDir}/Speedtest/result.txt ${WorkDir}/result/07-speedtest.result
    fi
}

Function_GenerateResult_BestTrace() {
    sleep 0.1
    if [ -f "${WorkDir}/BestTrace/result.txt" ]; then
        cp -f ${WorkDir}/BestTrace/result.txt ${WorkDir}/result/08-besttrace.result
    fi
}

Function_GenerateResult_Spoofer() {
    sleep 0.1
    if [ -f "${WorkDir}/Spoofer/result.txt" ]; then
        cp -f ${WorkDir}/Spoofer/result.txt ${WorkDir}/result/09-spoofer.result
    fi
}

Function_GenerateResult_Footer() {
    sleep 0.1
    local rfile="${WorkDir}/result/99-footer.result"
    echo -e "\nGenerated by LemonBench on $(date -u "+%Y-%m-%dT%H:%M:%SZ") Version ${BuildTime}\n" >>$rfile
    # 恰饭时间！（雾
    echo -e "[AD] 高质量美西CN2 GIA with ARIN IP (可直接解锁常见流媒体)，1核心/2G内存/15G SSD/1IP/1TB单向流量\n季付仅需588元/季度，年付仅需1899元/年，做站理想之选！\n使用优惠码 BW9K1IPZXN 即刻享受优惠价格！ \n购买传送门： http://ilemonra.in/HKSSLaxGIAPromo" >>$rfile
    echo -e " \n"  >>$rfile
}
