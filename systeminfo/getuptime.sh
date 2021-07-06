SystemInfo_GetUptime() {
    local ut="$(cat /proc/uptime | awk '{printf "%d\n",$1}')"
    local ut_day="$(echo $result | awk -v ut="$ut" '{printf "%d\n",ut/86400}')"
    local ut_hour="$(echo $result | awk -v ut="$ut" -v ut_day="$ut_day" '{printf "%d\n",(ut-(86400*ut_day))/3600}')"
    local ut_minute="$(echo $result | awk -v ut="$ut" -v ut_day="$ut_day" -v ut_hour="$ut_hour" '{printf "%d\n",(ut-(86400*ut_day)-(3600*ut_hour))/60}')"
    local ut_second="$(echo $result | awk -v ut="$ut" -v ut_day="$ut_day" -v ut_hour="$ut_hour" -v ut_minute="$ut_minute" '{printf "%d\n",(ut-(86400*ut_day)-(3600*ut_hour)-(60*ut_minute))}')"
    LBench_Result_SystemInfo_Uptime_Day="$ut_day"
    LBench_Result_SystemInfo_Uptime_Hour="$ut_hour"
    LBench_Result_SystemInfo_Uptime_Minute="$ut_minute"
    LBench_Result_SystemInfo_Uptime_Second="$ut_second"
}
