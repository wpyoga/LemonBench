# 流媒体解锁测试-Abema.TV
#
Function_MediaUnlockTest_AbemaTV_IPTest() {
    echo -n -e " Abema.TV:\t\t\t\t\c"
    # 
    # 第一轮判断: 判断IP是否为日本IP (通过Akamai)
    # 如果不是日本IP, 后续没必要继续判断了
    local result="$(curl --user-agent "${UA_Browser}" -4 -fsL --write-out %{http_code} --max-time 30 --output /dev/null http://abematv.akamaized.net/region)"
    if [ "$?" = "0" ]; then
        if [ "${result}" = "200" ]; then
            # 当Akamai 返回 HTTP 200 (OK) 时, 继续第二轮判断
            local result="$(curl --user-agent "${UA_Browser}" -4 -fsL https://abema.tv/now-on-air/abema-news)"
            local result="$(curl --user-agent "${UA_Browser}" -4 -fsL https://abema.tv/now-on-air/abema-news)"
            local result1="$(echo $result | awk -F ' = ' '/window.__CLIENT_REGION__/{print $2$3}' | grep -oP '(?<='isAllowed'":)[0-9A-Za-z]+')"
            local result2="$(echo $result | awk -F ' = ' '/window.__CLIENT_REGION__/{print $2$3}' | grep -oP '(?<='status'":)[0-9A-Za-z]+')"
            if [ "${result1}" = "true" ] && [ "${result2}" = "true" ]; then
                echo -n -e "\r Abema.TV:\t\t\t\t${Font_Green}Yes${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_AbemaTV_IPTest="Yes"
            elif [ "${result1}" = "true" ] && [ "${result2}" = "false" ]; then
                echo -n -e "\r Abema.TV:\t\t\t\t${Font_Green}Yes${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_AbemaTV_IPTest="Yes"
            elif [ "${result1}" = "false" ] && [ "${result2}" = "true" ]; then
                echo -n -e "\r Abema.TV:\t\t\t\t${Font_Red}No${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_AbemaTV_IPTest="No"
            elif [ "${result1}" = "false" ] && [ "${result2}" = "false" ]; then
                echo -n -e "\r Abema.TV:\t\t\t\t${Font_Red}No${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_AbemaTV_IPTest="No"
            else
                echo -n -e "\r Abema.TV:\t\t\t\t${Font_Red}Failed (Unexpected Return Value)${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_AbemaTV_IPTest="Failed (Unexpected Return Value)"
            fi            
        elif [ "${result}" = "403" ]; then
            echo -n -e "\r Abema.TV:\t\t\t\t${Font_Red}No${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_AbemaTV_IPTest="No"
        elif [ "${result}" = "404" ]; then
            echo -n -e "\r Abema.TV:\t\t\t\t${Font_Red}Failed (HTTP 404 Caught)${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_AbemaTV_IPTest="Failed (HTTP 404 Caught)"
        elif [ "${result}" = "000" ]; then
            echo -n -e "\r Abema.TV:\t\t\t\t${Font_Red}No${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_AbemaTV_IPTest="No"
        else
            echo -n -e "\r Abema.TV:\t\t\t\t${Font_Red}Failed (Unexpected HTTP Code)${Font_Suffix} ${Font_SkyBlue}(${result})${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_AbemaTV_IPTest="Failed (Unexpected HTTP Code)" 
        fi
    else
        echo -n -e "\r Abema.TV:\t\t\t\t${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        LemonBench_Result_MediaUnlockTest_AbemaTV_IPTest="Failed (Network Connection)"        
    fi
}
