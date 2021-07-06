# =============== SysBench - CPU性能 部分 ===============
Run_SysBench_CPU() {
    # 调用方式: Run_SysBench_CPU "线程数" "测试时长(s)" "测试遍数" "说明"
    # 变量初始化
    mkdir -p ${WorkDir}/SysBench/CPU/ >/dev/null 2>&1
    maxtestcount="$3"
    local count="1"
    local TestScore="0"
    local TotalScore="0"
    # 运行测试
    while [ $count -le $maxtestcount ]; do
        echo -e "\r ${Font_Yellow}$4: ${Font_Suffix}\t\t$count/$maxtestcount \c"
        local TestResult="$(sysbench --test=cpu --num-threads=$1 --cpu-max-prime=10000 --max-requests=1000000 --max-time=$2 run 2>&1)"
        local TestScore="$(echo ${TestResult} | grep -oE "events per second: [0-9]+" | grep -oE "[0-9]+")"
        local TotalScore="$(echo "${TotalScore} ${TestScore}" | awk '{printf "%d",$1+$2}')"
        let count=count+1
        local TestResult=""
        local TestScore="0"
    done
    local ResultScore="$(echo "${TotalScore} ${maxtestcount}" | awk '{printf "%d",$1/$2}')"
    if [ "$1" = "1" ]; then
        echo -e "\r ${Font_Yellow}$4: ${Font_Suffix}\t\t${Font_SkyBlue}${ResultScore}${Font_Suffix} ${Font_Yellow}Scores${Font_Suffix}"
        echo -e " $4:\t\t\t${ResultScore} Scores" >>${WorkDir}/SysBench/CPU/result.txt
    elif [ "$1" -ge "2" ]; then
        echo -e "\r ${Font_Yellow}$4: ${Font_Suffix}\t\t${Font_SkyBlue}${ResultScore}${Font_Suffix} ${Font_Yellow}Scores${Font_Suffix}"
        echo -e " $4:\t\t${ResultScore} Scores" >>${WorkDir}/SysBench/CPU/result.txt
    fi
}

Function_SysBench_CPU_Fast() {
    mkdir -p ${WorkDir}/SysBench/CPU/ >/dev/null 2>&1
    echo -e "\n ${Font_Yellow}-> CPU Performance Test (Fast Mode, 1-Pass @ 5sec)${Font_Suffix}\n"
    echo -e "\n -> CPU Performance Test (Fast Mode, 1-Pass @ 5sec)\n" >>${WorkDir}/SysBench/CPU/result.txt
    Run_SysBench_CPU "1" "5" "1" "1 Thread Test"
    if [ "${LBench_Result_CPUThreadNumber}" -ge "2" ]; then
        Run_SysBench_CPU "${LBench_Result_CPUThreadNumber}" "5" "1" "${LBench_Result_CPUThreadNumber} Threads Test"
    elif [ "${LBench_Result_CPUProcessorNumber}" -ge "2" ]; then
        Run_SysBench_CPU "${LBench_Result_CPUProcessorNumber}" "5" "1" "${LBench_Result_CPUProcessorNumber} Threads Test"
    fi
    # 完成FLAG
    LBench_Flag_FinishSysBenchCPUFast="1"
}

Function_SysBench_CPU_Full() {
    mkdir -p ${WorkDir}/SysBench/CPU/ >/dev/null 2>&1
    echo -e "\n ${Font_Yellow}-> CPU Performance Test (Standard Mode, 3-Pass @ 30sec)${Font_Suffix}\n"
    echo -e "\n -> CPU Performance Test (Standard Mode, 3-Pass @ 30sec)\n" >>${WorkDir}/SysBench/CPU/result.txt
    Run_SysBench_CPU "1" "50" "3" "1 Thread Test"
    if [ "${LBench_Result_CPUThreadNumber}" -ge "2" ]; then
        Run_SysBench_CPU "${LBench_Result_CPUThreadNumber}" "50" "3" "${LBench_Result_CPUThreadNumber} Threads Test"
    elif [ "${LBench_Result_CPUProcessorNumber}" -ge "2" ]; then
        Run_SysBench_CPU "${LBench_Result_CPUProcessorNumber}" "50" "3" "${LBench_Result_CPUProcessorNumber} Threads Test"
    fi
    # 完成FLAG
    LBench_Flag_FinishSysBenchCPUFull="1"
    sleep 1
}
