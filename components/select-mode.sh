# 全局入口
echo " "
if [ "${#SingleTestList[@]}" -eq "0" ] && [ "${GlobalVar_TestMode}" = "" ]; then
    Entrance_HelpDocument
    exit 1
elif [ "${GlobalVar_TestMode}" = "fast" ]; then
    Global_Startup_Header
    Entrance_FastBench
elif [ "${GlobalVar_TestMode}" = "full" ]; then
    Global_Startup_Header
    Entrance_FullBench
elif [ "${GlobalVar_TestMode}" = "mediaunlocktest" ]; then
    Global_Startup_Header
    Entrance_MediaUnlockTest
elif [ "${GlobalVar_TestMode}" = "disktest-fast" ]; then
    Global_Startup_Header
    Entrance_DiskTest_Fast
elif [ "${GlobalVar_TestMode}" = "disktest-full" ]; then
    Global_Startup_Header
    Entrance_DiskTest_Full
elif [ "${GlobalVar_TestMode}" = "speedtest-fast" ]; then
    Global_Startup_Header
    Entrance_Speedtest_Fast
elif [ "${GlobalVar_TestMode}" = "speedtest-full" ]; then
    Global_Startup_Header
    Entrance_Speedtest_Full
elif [ "${GlobalVar_TestMode}" = "besttrace-fast" ]; then
    Global_Startup_Header
    Entrance_BestTrace_Fast
elif [ "${GlobalVar_TestMode}" = "besttrace-full" ]; then
    Global_Startup_Header
    Entrance_BestTrace_Full
elif [ "${GlobalVar_TestMode}" = "spoof" ]; then
    Global_Startup_Header
    Entrance_Spoofer
elif [ "${GlobalVar_TestMode}" = "sysbench-cpu-fast" ]; then
    Global_Startup_Header
    Entrance_SysBench_CPU_Fast
elif [ "${GlobalVar_TestMode}" = "sysbench-cpu-full" ]; then
    Global_Startup_Header
    Entrance_SysBench_CPU_Full
elif [ "${GlobalVar_TestMode}" = "sysbench-memory-fast" ]; then
    Global_Startup_Header
    Entrance_SysBench_Memory_Fast
elif [ "${GlobalVar_TestMode}" = "sysbench-memory-full" ]; then
    Global_Startup_Header
    Entrance_SysBench_Memory_Full
else
    Entrance_HelpDocument
    exit 1
fi
