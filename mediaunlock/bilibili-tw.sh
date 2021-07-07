# 流媒体解锁测试-哔哩哔哩台湾限定
Function_MediaUnlockTest_BilibiliTW() {
    echo -n -e " Bilibili Taiwan Only:\t\t\t->\c"
    local randsession="$(cat /dev/urandom | head -n 32 | md5sum | head -c 32)"
    # 尝试获取成功的结果
    local result="$(curl --user-agent "${UA_Browser}" -4 -fsL --max-time 30 "https://api.bilibili.com/pgc/player/web/playurl?avid=50762638&cid=100279344&qn=0&type=&otype=json&ep_id=268176&fourk=1&fnver=0&fnval=16&session=${randsession}&module=bangumi")"
    if [ "$?" = "0" ]; then
        local result="$(PharseJSON "${result}" "code")"
        if [ "$?" = "0" ]; then
            if [ "${result}" = "0" ]; then
                echo -n -e "\r Bilibili Taiwan Only:\t\t\t${Font_Green}Yes${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_BilibiliTW="Yes"
            elif [ "${result}" = "-10403" ]; then
                echo -n -e "\r Bilibili Taiwan Only:\t\t\t${Font_Red}No${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_BilibiliTW="No"
            else
                echo -n -e "\r Bilibili Taiwan Only:\t\t\t${Font_Red}Failed (due to unknown return)${Font_Suffix} ${Font_SkyBlue}(${result})${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_BilibiliTW="Failed (due to unknown return)" 
            fi
        else
            echo -n -e "\r Bilibili Taiwan Only:\t\t\t${Font_Red}Failed (due to parse fail)${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_BilibiliTW="Failed (due to parse fail)"
        fi
    else
        echo -n -e "\r 哔哩哔哩-台湾限定:\t${Font_Red}Failed (due to network fail)${Font_Suffix}\n"
        LemonBench_Result_MediaUnlockTest_BilibiliTW="Failed (due to network fail)"        
    fi   
}
