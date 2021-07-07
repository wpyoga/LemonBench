# 流媒体解锁测试-哔哩哔哩大陆限定
Function_MediaUnlockTest_BilibiliChinaMainland() {
    echo -n -e " BiliBili China Mainland Only:\t\t->\c"
    local randsession="$(cat /dev/urandom | head -n 32 | md5sum | head -c 32)"
    # 尝试获取成功的结果
    local result="$(curl --user-agent "${UA_Browser}" -4 -fsL --max-time 30 "https://api.bilibili.com/pgc/player/web/playurl?avid=82846771&qn=0&type=&otype=json&ep_id=307247&fourk=1&fnver=0&fnval=16&session=${randsession}&module=bangumi")"
    if [ "$?" = "0" ]; then
        local result="$(PharseJSON "${result}" "code")"
        if [ "$?" = "0" ]; then
            if [ "${result}" = "0" ]; then
                echo -n -e "\r BiliBili China Mainland Only:\t\t${Font_Green}Yes${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_ChinaMainland="Yes"
            elif [ "${result}" = "-10403" ]; then
                echo -n -e "\r BiliBili China Mainland Only:\t\t${Font_Red}No${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_ChinaMainland="No"
            else
                echo -n -e "\r BiliBili China Mainland Only:\t\t${Font_Red}Failed (due to unknown return)${Font_Suffix} ${Font_SkyBlue}(${result})${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_ChinaMainland="Failed (due to unknown return)" 
            fi
        else
            echo -n -e "\r BiliBili China Mainland Only:\t\t${Font_Red}Failed (due to parse fail)${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_ChinaMainland="Failed (due to parse fail)"
        fi
    else
        echo -n -e "\r BiliBili China Mainland Only:\t\t${Font_Red}Failed (due to network fail)${Font_Suffix}\n"
        LemonBench_Result_MediaUnlockTest_ChinaMainland="Failed (due to network fail)"        
    fi   
}
