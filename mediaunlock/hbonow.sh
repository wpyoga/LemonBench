# 流媒体解锁测试-HBO Now
Function_MediaUnlockTest_HBONow() {
    echo -n -e " HBO Now:\t\t\t\t->\c"
    # 尝试获取成功的结果
    local result="$(curl --user-agent "${UA_Browser}" -4 -fsL --max-time 30 --write-out "%{url_effective}\n" --output /dev/null https://play.hbonow.com/)"
    if [ "$?" = "0" ]; then
        # 下载页面成功，开始解析跳转
        if [ "${result}" = "https://play.hbonow.com" ] || [ "${result}" = "https://play.hbonow.com/" ]; then
            echo -n -e "\r HBO Now:\t\t\t\t${Font_Green}Yes${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_HBONow="Yes"
        elif [ "${result}" = "http://hbogeo.cust.footprint.net/hbonow/geo.html" ] || [ "${result}" = "http://geocust.hbonow.com/hbonow/geo.html" ]; then
            echo -n -e "\r HBO Now:\t\t\t\t${Font_Red}No${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_HBONow="No"
        else
            echo -n -e "\r HBO Now:\t\t\t\t${Font_Yellow}Failed (due to parse fail)${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_HBONow="Failed (due to parse fail)"
        fi
    else
        # 下载页面失败，返回错误代码
        echo -e "\r HBO Now:\t\t\t\t${Font_Yellow}Failed (due to network fail)${Font_Suffix}\n"
        LemonBench_Result_MediaUnlockTest_HBONow="Failed (due to network fail)"
    fi
}
