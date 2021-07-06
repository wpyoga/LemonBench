# =============== 全局启动信息 ===============
Global_Startup_Header() {
    echo -e "
 ${Font_Green}#-----------------------------------------------------------#${Font_Suffix}
 ${Font_Green}@${Font_Suffix}    ${Font_Blue}LemonBench${Font_Suffix} ${Font_Yellow}Server Evaluation & Benchmark Ultility${Font_Suffix}      ${Font_Green}@${Font_Suffix}
 ${Font_Green}#-----------------------------------------------------------#${Font_Suffix}
 ${Font_Green}@${Font_Suffix} ${Font_Purple}Written by${Font_Suffix} ${Font_SkyBlue}iLemonrain${Font_Suffix} ${Font_Blue}<ilemonrain@ilemonrain.com>${Font_Suffix}         ${Font_Green}@${Font_Suffix}
 ${Font_Green}@${Font_Suffix} ${Font_Purple}My Blog:${Font_Suffix} ${Font_SkyBlue}https://ilemonrain.com${Font_Suffix}                           ${Font_Green}@${Font_Suffix}
 ${Font_Green}@${Font_Suffix} ${Font_Purple}Telegram:${Font_Suffix} ${Font_SkyBlue}https://t.me/ilemonrain${Font_Suffix}                         ${Font_Green}@${Font_Suffix}
 ${Font_Green}@${Font_Suffix} ${Font_Purple}Telegram (For +86 User):${Font_Suffix} ${Font_SkyBlue}https://t.me/ilemonrain_chatbot${Font_Suffix}  ${Font_Green}@${Font_Suffix}
 ${Font_Green}@${Font_Suffix} ${Font_Purple}Telegram Channel:${Font_Suffix} ${Font_SkyBlue}https://t.me/ilemonrain_channel${Font_Suffix}         ${Font_Green}@${Font_Suffix}
 ${Font_Green}#-----------------------------------------------------------#${Font_Suffix}

 Version: ${BuildTime}

 Reporting Bugs Via:
 https://t.me/ilemonrain 或 https://t.me/ilemonrain_chatbot
 (简体中文/繁體中文/English only)
 
 Thanks for using！

 Usage (two way):
 (1) wget -O- https://ilemonrain.com/download/shell/LemonBench.sh | bash
 (2) curl -fsL https://ilemonrain.com/download/shell/LemonBench.sh | bash

"
}

# =============== 入口 - 快速测试 (fast) ===============
Entrance_FastBench() {
    Global_TestMode="fast"
    Global_TestModeTips="Fast Mode"
    Global_StartupInit_Action
    Function_GetSystemInfo
    Function_BenchStart
    Function_ShowSystemInfo
    Function_ShowNetworkInfo
    Function_MediaUnlockTest
    Function_SysBench_CPU_Fast
    Function_SysBench_Memory_Fast
    Function_DiskTest_Fast
    Function_Speedtest_Fast
    Function_BestTrace_Fast
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}

# =============== 入口 - 完全测试 (full) ===============
Entrance_FullBench() {
    Global_TestMode="full"
    Global_TestModeTips="Full Mode"
    Global_StartupInit_Action
    Function_GetSystemInfo
    Function_BenchStart
    Function_ShowSystemInfo
    Function_ShowNetworkInfo
    Function_MediaUnlockTest
    Function_SysBench_CPU_Full
    Function_SysBench_Memory_Full
    Function_DiskTest_Full
    Function_Speedtest_Full
    Function_BestTrace_Full
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}

# =============== 入口 - 仅流媒体解锁测试 (mlt) ===============
Entrance_MediaUnlockTest() {
    Global_Startup_Header
    Global_TestMode="mediaunlocktest"
    Global_TestModeTips="Media Unlock Test Only"
    Check_JSONQuery
    Function_BenchStart
    Function_MediaUnlockTest
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}

# =============== 入口 - 仅Speedtest测试-快速模式 (spfast) ===============
Entrance_Speedtest_Fast() {
    Global_Startup_Header
    Global_TestMode="speedtest-fast"
    Global_TestModeTips="Speedtest Only (Fast Mode)"
    Function_BenchStart
    Check_Speedtest
    Function_Speedtest_Fast
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}

# =============== 入口 - 仅Speedtest测试-全面模式 (spfull) ===============
Entrance_Speedtest_Full() {
    Global_Startup_Header
    Global_TestMode="speedtest-full"
    Global_TestModeTips="Speedtest Only (Full Mode)"
    Check_Speedtest
    Function_BenchStart
    Function_Speedtest_Full
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}

# =============== 入口 - 仅磁盘性能测试-快速模式 (dtfast) ===============
Entrance_DiskTest_Fast() {
    Global_Startup_Header
    Global_TestMode="disktest-fast"
    Global_TestModeTips="Disk Performance Test Only (Fast Mode)"
    Function_BenchStart
    Function_DiskTest_Fast
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}

# =============== 入口 - 仅磁盘性能测试-全面模式 (dtfull) ===============
Entrance_DiskTest_Full() {
    Global_Startup_Header
    Global_TestMode="disktest-full"
    Global_TestModeTips="Disk Performance Test Only (Full Mode)"
    Function_BenchStart
    Function_DiskTest_Full
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}

# =============== 入口 - 仅路由追踪测试-快速模式 (btfast) ===============
Entrance_BestTrace_Fast() {
    Global_Startup_Header
    Global_TestMode="besttrace-fast"
    Global_TestModeTips="Traceroute Test Only (Fast Mode)"
    Function_CheckTracemode
    Check_JSONQuery
    Check_BestTrace
    echo -e "${Msg_Info}Collecting Network Info ..."
    SystemInfo_GetNetworkInfo
    Function_BenchStart
    Function_ShowNetworkInfo
    Function_BestTrace_Fast
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}

# =============== 入口 - 仅路由追踪测试-完全模式 (btfull) ===============
Entrance_BestTrace_Full() {
    Global_Startup_Header
    Global_TestMode="besttrace-full"
    Global_TestModeTips="Traceroute Test Only (Full Mode)"
    Function_CheckTracemode
    Check_JSONQuery
    Check_BestTrace
    echo -e "${Msg_Info}Collecting Network Info ..."
    SystemInfo_GetNetworkInfo
    Function_BenchStart
    Function_ShowNetworkInfo
    Function_BestTrace_Full
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}

# =============== 入口 - 仅Spoofer测试-快速模式 (spf) ===============
Entrance_Spoofer() {
    Global_Startup_Header
    Function_SpooferWarning
    Global_TestMode="spoofer"
    Global_TestModeTips="Spoof Test Only"
    Check_Spoofer
    Function_BenchStart
    Function_SpooferTest
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}


Entrance_SysBench_CPU_Fast() {
    Global_Startup_Header
    Global_TestMode="sysbench-cpu-fast"
    Global_TestModeTips="CPU Performance Test Only (Fast Mode)"
    Check_SysBench
    Function_BenchStart
    SystemInfo_GetCPUInfo
    Function_SysBench_CPU_Fast
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}

Entrance_SysBench_CPU_Full() {
    Global_Startup_Header
    Global_TestMode="sysbench-cpu-full"
    Global_TestModeTips="CPU Performance Test Only (Standard Mode)"
    Check_SysBench
    Function_BenchStart
    SystemInfo_GetCPUInfo
    Function_SysBench_CPU_Full
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}

#
Entrance_SysBench_Memory_Fast() {
    Global_Startup_Header
    Global_TestMode="sysbench-memory-fast"
    Global_TestModeTips="Memory Performance Test Only (Fast Mode)"
    Check_SysBench
    Function_BenchStart
    SystemInfo_GetCPUInfo
    Function_SysBench_Memory_Fast
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}

Entrance_SysBench_Memory_Full() {
    Global_Startup_Header
    Global_TestMode="sysbench-memory-full"
    Global_TestModeTips="Memory Performance Test Only (Standard Mode)"
    Check_SysBench
    Function_BenchStart
    SystemInfo_GetCPUInfo
    Function_SysBench_Memory_Full
    Function_BenchFinish
    Function_GenerateResult
    Global_Exit_Action
}

# =============== 入口 - 帮助文档 (help) ===============
Entrance_HelpDocument() {
    echo -e " "
    echo -e " ${Font_SkyBlue}LemonBench${Font_Suffix} ${Font_Yellow}Server Performace Test Utility${Font_Suffix}"
    echo -e " "
    echo -e " ${Font_Yellow}Written by:${Font_Suffix}\t\t ${Font_SkyBlue}iLemonrain <ilemonrain@ilemonrain.com>${Font_Suffix}"
    echo -e " ${Font_Yellow}Project Homepage:${Font_Suffix}\t ${Font_SkyBlue}https://blog.ilemonrain.com/linux/LemonBench.html${Font_Suffix}"
    echo -e " ${Font_Yellow}Code Version:${Font_Suffix}\t\t ${Font_SkyBlue}${BuildTime}${Font_Suffix}"
    echo -e " "
    echo -e " Usage:"
    echo -e " ${Font_SkyBlue}>> One-Key Benchmark${Font_Suffix}"
    echo -e " ${Font_Yellow}--mode TestMode${Font_Suffix}\t${Font_SkyBlue}Test Mode (fast/full, aka FastMode/FullMode)${Font_Suffix}"
    echo -e " "
    echo -e " ${Font_SkyBlue}>> Single Test${Font_Suffix}"
    echo -e " ${Font_Yellow}--dtfast${Font_Suffix}\t\t${Font_SkyBlue}Disk Test (Fast Test Mode)${Font_Suffix}"
    echo -e " ${Font_Yellow}--dtfull${Font_Suffix}\t\t${Font_SkyBlue}Disk Test (Full Test Mode)${Font_Suffix}"
    echo -e " ${Font_Yellow}--spfast${Font_Suffix}\t\t${Font_SkyBlue}Speedtest Test (Fast Test Mode)${Font_Suffix}"
    echo -e " ${Font_Yellow}--spfull${Font_Suffix}\t\t${Font_SkyBlue}Speedtest Test (Full Test Mode)${Font_Suffix}"
    echo -e " ${Font_Yellow}--trfast${Font_Suffix}\t\t${Font_SkyBlue}Traceroute Test (Fast Test Mode)${Font_Suffix}"
    echo -e " ${Font_Yellow}--trfull${Font_Suffix}\t\t${Font_SkyBlue}Traceroute Test (Full Test Mode)${Font_Suffix}"
    echo -e " ${Font_Yellow}--sbcfast${Font_Suffix}\t\t${Font_SkyBlue}CPU Benchmark Test (Fast Test Mode)${Font_Suffix}"
    echo -e " ${Font_Yellow}--sbcfull${Font_Suffix}\t\t${Font_SkyBlue}CPU Benchmark Test (Full Test Mode)${Font_Suffix}"
    echo -e " ${Font_Yellow}--sbmfast${Font_Suffix}\t\t${Font_SkyBlue}Memory Benchmark Test (Fast Test Mode)${Font_Suffix}"
    echo -e " ${Font_Yellow}--sbmfull${Font_Suffix}\t\t${Font_SkyBlue}Memory Benchmark Test (Full Test Mode)${Font_Suffix}"    
    echo -e " ${Font_Yellow}--spoof${Font_Suffix}\t\t${Font_SkyBlue}Caida Spoofer Test ${Font_Yellow}(Use it at your own risk)${Font_Suffix}${Font_Suffix}"
}
