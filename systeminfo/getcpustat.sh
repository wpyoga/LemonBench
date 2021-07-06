SystemInfo_GetCPUStat() {
    local CPUStat_Result="$(top -bn1 | grep Cpu)"
    # 原始数据
    LBench_Result_CPUStat_user="$(Function_ReadCPUStat "${CPUStat_Result}" "us")"
    LBench_Result_CPUStat_system="$(Function_ReadCPUStat "${CPUStat_Result}" "sy")"
    LBench_Result_CPUStat_anice="$(Function_ReadCPUStat "${CPUStat_Result}" "ni")"
    LBench_Result_CPUStat_idle="$(Function_ReadCPUStat "${CPUStat_Result}" "id")"
    LBench_Result_CPUStat_iowait="$(Function_ReadCPUStat "${CPUStat_Result}" "wa")"
    LBench_Result_CPUStat_hardint="$(Function_ReadCPUStat "${CPUStat_Result}" "hi")"
    LBench_Result_CPUStat_softint="$(Function_ReadCPUStat "${CPUStat_Result}" "si")"
    LBench_Result_CPUStat_steal="$(Function_ReadCPUStat "${CPUStat_Result}" "st")"
    # 加工后的数据
    LBench_Result_CPUStat_UsedAll="$(echo ${LBench_Result_CPUStat_user} ${LBench_Result_CPUStat_system} ${LBench_Result_CPUStat_nice} | awk '{printf "%.1f\n",$1+$2+$3}')"
}
