# =============== 测试启动与结束动作 ===============
Function_BenchStart() {
    clear
    LBench_Result_BenchStartTime="$(date +"%Y-%m-%d %H:%M:%S")"
    LBench_Result_BenchStartTimestamp="$(date +%s)"
    echo -e "${Font_SkyBlue}LemonBench${Font_Suffix} ${Font_Yellow}Server Test Tookit${Font_Suffix} ${BuildTime} ${Font_SkyBlue}(C)iLemonrain. All Rights Reserved.${Font_Suffix}"
    echo -e "=========================================================================================="
    echo -e " "
    echo -e " ${Msg_Info}${Font_Yellow}Bench Start Time:${Font_Suffix} ${Font_SkyBlue}${LBench_Result_BenchStartTime}${Font_Suffix}"
    echo -e " ${Msg_Info}${Font_Yellow}Test Mode:${Font_Suffix} ${Font_SkyBlue}${Global_TestModeTips}${Font_Suffix}"
    echo -e " "
}

Function_BenchFinish() {
    # 清理临时文件
    LBench_Result_BenchFinishTime="$(date +"%Y-%m-%d %H:%M:%S")"
    LBench_Result_BenchFinishTimestamp="$(date +%s)"
    LBench_Result_TimeElapsedSec="$(echo "$LBench_Result_BenchFinishTimestamp $LBench_Result_BenchStartTimestamp" | awk '{print $1-$2}')"
    echo -e ""
    echo -e "=========================================================================================="
    echo -e " "
    echo -e " ${Msg_Info}${Font_Yellow}Bench Finish Time:${Font_Suffix} ${Font_SkyBlue}${LBench_Result_BenchFinishTime}${Font_Suffix}"
    echo -e " ${Msg_Info}${Font_Yellow}Time Elapsed:${Font_Suffix} ${Font_SkyBlue}${LBench_Result_TimeElapsedSec} seconds${Font_Suffix}"
    echo -e " "
}
