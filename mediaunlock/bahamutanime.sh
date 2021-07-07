# 流媒体解锁测试-动画疯
Function_MediaUnlockTest_BahamutAnime() {
    echo -n -e " Bahamut Anime:\t\t\t\t->\c"
    # 尝试获取成功的结果
    # local result="$(curl -4 --user-agent "${UA_Browser}" --output /dev/null --write-out "%{url_effective}" --max-time 30 -fsL https://ani.gamer.com.tw/animePay.php)"
    local tmpresult="$(curl -4 --user-agent "${UA_Browser}" --max-time 30 -fsL 'https://ani.gamer.com.tw/ajax/token.php?adID=89422&sn=14667')"
    if [ "$?" != "0" ]; then
        echo -n -e "\r Bahamut Anime:\t\t\t\t${Font_Red}Failed (due to network fail)${Font_Suffix}\n"
        LemonBench_Result_MediaUnlockTest_BahamutAnime="Failed (due to network fail)" 
        return 1
    fi
    local result="$(echo $tmpresult | jq -r .animeSn)"
    if [ "$result" != "null" ]; then
        resultverify="$(echo $result | grep -oE '[0-9]{1,}')"
        if [ "$?" = "0" ]; then
            echo -n -e "\r Bahamut Anime:\t\t\t\t${Font_Green}Yes${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_BahamutAnime="Yes"
        else
            echo -n -e "\r Bahamut Anime:\t\t\t\t${Font_Red}Failed (due to parse fail)${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_BahamutAnime="Failed (due to parse fail)"            
        fi
    else
        local result="$(echo $tmpresult | jq -r .error.code)"
        if [ "$result" != "null" ]; then
            resultverify="$(echo $result | grep -oE '[0-9]{1,}')"
            if [ "$?" = "0" ]; then
                echo -n -e "\r Bahamut Anime:\t\t\t\t${Font_Red}No${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_BahamutAnime="No"
            else
                echo -n -e "\r Bahamut Anime:\t\t\t\t${Font_Red}Failed (due to parse fail)${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_BahamutAnime="Failed (due to parse fail)"                 
            fi
        else
            echo -n -e "\r Bahamut Anime:\t\t\t\t${Font_Red}Failed (due to parse fail)${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_BahamutAnime="Failed (due to parse fail)"    
        fi
    fi
}
