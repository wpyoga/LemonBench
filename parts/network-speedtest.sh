# =============== Speedtest 部分 ===============
Run_Speedtest() {
    # 调用方式: Run_Speedtest "服务器ID" "节点名称(用于显示)"
    echo -n -e " $2\t\t->\c"
    mkdir -p ${WorkDir}/result/speedtest/ >/dev/null 2>&1
    if [ "$1" = "default" ]; then
        local result="$(/usr/local/lemonbench/bin/speedtest --accept-license --accept-gdpr --format=json --unit=MiB/s --progress=no 2>/dev/null)"
    elif [ "$1" = "" ]; then
        echo -n -e "\r $2\t\t${Font_Red}Fail: Invalid Speedtest Server (No servers defined)${Font_Suffix}\n"
        echo -e " $2\t\tFail: Invalid Speedtest Server (No servers defined)" >>${WorkDir}/Speedtest/result.txt
    else
        local result="$(/usr/local/lemonbench/bin/speedtest --accept-license --accept-gdpr --format=json --unit=MiB/s --progress=no --server-id $1 2>/dev/null)"
    fi
    # 处理结果
    local getresultid="$(echo $result | jq -r .result.id | grep -v null)"
    if [ "${getresultid}" != "" ]; then
        # 上传速度 (Raw Data, 单位: bytes)
        local rr_upload_bandwidth="$(echo $result | jq -r .upload.bandwidth)"
        # 下载速度 (Raw Data, 单位: bytes)
        local rr_download_bandwidth="$(echo $result | jq -r .download.bandwidth)"
        # Ping 延迟 (Raw Data, 单位: ms)
        local rr_ping_latency="$(echo $result | jq -r .ping.latency)"
        # echo -e " Node Name\t\t\tUpload Speed\tDownload Speed\tPing Latency" >>${WorkDir}/Speedtest/result.txt
        # 处理数据
        # 处理上传速度与下载速度，从B/s转换成MB/s
        local fr_upload_bandwidth="$(echo $rr_upload_bandwidth | awk '{printf"%.2f",$1/1024/1024}')"
        local fr_download_bandwidth="$(echo $rr_download_bandwidth | awk '{printf"%.2f",$1/1024/1024}')"
        # 处理Ping值数据，如果大于1000，只输出整位，否则保留两位小数
        local fr_ping_latency="$(echo $rr_ping_latency | awk '{if($1>=1000){printf"%d",$1}else{printf"%.2f",$1}}')"
        # 输出结果
        echo -n -e "\r $2\t\t${Font_SkyBlue}${fr_upload_bandwidth}${Font_Suffix} MB/s\t${Font_SkyBlue}${fr_download_bandwidth}${Font_Suffix} MB/s\t${Font_SkyBlue}${fr_ping_latency}${Font_Suffix} ms\n"
        echo -e " $2\t\t${fr_upload_bandwidth} MB/s\t${fr_download_bandwidth} MB/s\t${fr_ping_latency} ms" >>${WorkDir}/Speedtest/result.txt
    else
        local getlevel="$(echo $result | jq -r .level)"
        if [ "${getlevel}" = "error" ]; then
            local getmessage="$(echo $result | jq -r .message)"
            echo -n -e "\r $2\t\t${Font_Red}Fail: ${getmessage}${Font_Suffix}\n"
            echo -e " $2\t\tFail: ${getmessage}" >>${WorkDir}/Speedtest/result.txt
        else
            echo -n -e "\r $2\t\t${Font_Red}Fail: ${result}${Font_Suffix}\n"
            echo -e " $2\t\tFail: Unknown Error" >>${WorkDir}/Speedtest/result.txt
        fi      
    fi
}

Function_Speedtest_Fast() {
    mkdir -p ${WorkDir}/Speedtest/ >/dev/null 2>&1
    echo -e "\n ${Font_Yellow}-> Speedtest.net Network Speed Test${Font_Suffix}\n"
    echo -e "\n -> Speedtest.net Network Speed Test\n" >>${WorkDir}/Speedtest/result.txt
    Check_JSONQuery
    Check_Speedtest
    echo -e " ${Font_Yellow}Node Name\t\t\tUpload Speed\tDownload Speed\tPing Latency${Font_Suffix}"
    echo -e " Node Name\t\t\tUpload Speed\tDownload Speed\tPing Latency" >>${WorkDir}/Speedtest/result.txt
    # 默认测试
    Run_Speedtest "default" "Speedtest Default"
    # 快速测试
    Run_Speedtest "9484" "China, Jilin CU"
    Run_Speedtest "15863" "China, Nanning CM"
    Run_Speedtest "26352" "China, Nanjing CT"
    # 执行完成, 标记FLAG
    LBench_Flag_FinishSpeedtestFast="1"
    sleep 1
}

Function_Speedtest_Full() {
    mkdir -p ${WorkDir}/Speedtest/ >/dev/null 2>&1
    echo -e "\n ${Font_Yellow}-> Speedtest.net Network Speed Test${Font_Suffix}\n"
    echo -e "\n -> Speedtest.net Network Speed Test\n" >>${WorkDir}/Speedtest/result.txt
    Check_JSONQuery
    Check_Speedtest
    echo -e " ${Font_Yellow}Node Name\t\t\tUpload Speed\tDownload Speed\tPing Latency${Font_Suffix}"
    echo -e " Node Name\t\t\tUpload Speed\tDownload Speed\tPing Latency" >>${WorkDir}/Speedtest/result.txt
    # 默认测试
    Run_Speedtest "default" "Speedtest Default"
    # 国内测试 - 联通组
    Run_Speedtest "9484" "China, Jilin CU"
    Run_Speedtest "17184" "China, Shandong CU"
    Run_Speedtest "13704" "China, Nanjing CU"
    Run_Speedtest "24447" "China, Shanghai CU"
    Run_Speedtest "4690" "China, Lanzhou CU"
    # 国内测试 - 电信组
    Run_Speedtest "27377" "China, Beijing CT"
    Run_Speedtest "7509" "China, Hangzhou CT"
    Run_Speedtest "26352" "China, Nanjing CT"
    Run_Speedtest "27594" "China, Guangzhou CT"
    Run_Speedtest "23844" "China, Wuhan CT"
    # 国内测试 - 移动组
    Run_Speedtest "16167" "China, Shenyang CM"
    Run_Speedtest "4647" "China, Hangzhou CM"
    Run_Speedtest "15863" "China, Nanning CM"
    Run_Speedtest "16145" "China, Lanzhou CM"
    # 海外测试
    Run_Speedtest "16176" "Hong Kong, HGC"
    Run_Speedtest "13538" "Hong Kong, CSL"
    Run_Speedtest "1536" "Hong Kong, PCCW"
    Run_Speedtest "6527" "Korea, SK [Kdatacenter]"
    Run_Speedtest "28910" "Japan, NTT [fdcservers]"
    Run_Speedtest "21569" "Japan, NTT [i3d]"
    Run_Speedtest "6087" "Japan GLBB"
    Run_Speedtest "24333" "Japan Rakuten"
    Run_Speedtest "17205" "Taiwan, Seednet"
    Run_Speedtest "4938" "Taiwan, HiNet"
    Run_Speedtest "11702" "Taiwan, TFN"
    Run_Speedtest "13623" "Singapore, Singtel"
    Run_Speedtest "7311" "Singapore, M1"
    Run_Speedtest "367" "Singapore, NME"
    Run_Speedtest "8864" "United States, Century Link"
    Run_Speedtest "29623" "United States, Verizon"
    # 执行完成, 标记FLAG
    LBench_Flag_FinishSpeedtestFull="1"
    sleep 1
}
