SystemInfo_GetMemInfo() {
    mkdir -p ${WorkDir}/data >/dev/null 2>&1
    cat /proc/meminfo >${WorkDir}/data/meminfo
    local ReadMemInfo="cat ${WorkDir}/data/meminfo"
    # 获取总内存
    LBench_Result_MemoryTotal_KB="$($ReadMemInfo | awk '/MemTotal/{print $2}')"
    LBench_Result_MemoryTotal_MB="$(echo $LBench_Result_MemoryTotal_KB | awk '{printf "%.2f\n",$1/1024}')"
    LBench_Result_MemoryTotal_GB="$(echo $LBench_Result_MemoryTotal_KB | awk '{printf "%.2f\n",$1/1048576}')"
    # 获取可用内存
    local MemFree="$($ReadMemInfo | awk '/MemFree/{print $2}')"
    local Buffers="$($ReadMemInfo | awk '/Buffers/{print $2}')"
    local Cached="$($ReadMemInfo | awk '/Cached/{print $2}')"
    LBench_Result_MemoryFree_KB="$(echo $MemFree $Buffers $Cached | awk '{printf $1+$2+$3}')"
    LBench_Result_MemoryFree_MB="$(echo $LBench_Result_MemoryFree_KB | awk '{printf "%.2f\n",$1/1024}')"
    LBench_Result_MemoryFree_GB="$(echo $LBench_Result_MemoryFree_KB | awk '{printf "%.2f\n",$1/1048576}')"
    # 获取已用内存
    local MemUsed="$(echo $LBench_Result_MemoryTotal_KB $LBench_Result_MemoryFree_KB | awk '{printf $1-$2}')"
    LBench_Result_MemoryUsed_KB="$MemUsed"
    LBench_Result_MemoryUsed_MB="$(echo $LBench_Result_MemoryUsed_KB | awk '{printf "%.2f\n",$1/1024}')"
    LBench_Result_MemoryUsed_GB="$(echo $LBench_Result_MemoryUsed_KB | awk '{printf "%.2f\n",$1/1048576}')"
    # 获取Swap总量
    LBench_Result_SwapTotal_KB="$($ReadMemInfo | awk '/SwapTotal/{print $2}')"
    LBench_Result_SwapTotal_MB="$(echo $LBench_Result_SwapTotal_KB | awk '{printf "%.2f\n",$1/1024}')"
    LBench_Result_SwapTotal_GB="$(echo $LBench_Result_SwapTotal_KB | awk '{printf "%.2f\n",$1/1048576}')"
    # 获取可用Swap
    LBench_Result_SwapFree_KB="$($ReadMemInfo | awk '/SwapFree/{print $2}')"
    LBench_Result_SwapFree_MB="$(echo $LBench_Result_SwapFree_KB | awk '{printf "%.2f\n",$1/1024}')"
    LBench_Result_SwapFree_GB="$(echo $LBench_Result_SwapFree_KB | awk '{printf "%.2f\n",$1/1048576}')"
    # 获取已用Swap
    local SwapUsed="$(echo $LBench_Result_SwapTotal_KB $LBench_Result_SwapFree_KB | awk '{printf $1-$2}')"
    LBench_Result_SwapUsed_KB="$SwapUsed"
    LBench_Result_SwapUsed_MB="$(echo $LBench_Result_SwapUsed_KB | awk '{printf "%.2f\n",$1/1024}')"
    LBench_Result_SwapUsed_GB="$(echo $LBench_Result_SwapUsed_KB | awk '{printf "%.2f\n",$1/1048576}')"
}
