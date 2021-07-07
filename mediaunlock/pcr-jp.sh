Function_MediaUnlockTest_PCRJP() {
    echo -n -e " Princess Connect Re:Dive Japan:\t\c"
    # 测试，连续请求两次 (单独请求一次可能会返回35, 第二次开始变成0)
    local result="$(curl --user-agent "${UA_Dalvik}" -4 -fsL --write-out %{http_code} --max-time 30 --output /dev/null https://api-priconne-redive.cygames.jp/)"
    local retval="$?"
    if [ "$retval" = "0" ]; then
        if [ "$result" = "404" ]; then
            echo -n -e "\r Princess Connect Re:Dive Japan:\t${Font_Green}Yes${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_PCRJP="Yes"
        elif [ "$result" = "403" ] || [ "$result" = "000" ]; then
            echo -n -e "\r Princess Connect Re:Dive Japan:\t${Font_Red}No${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_PCRJP="No"
        else
            echo -n -e "\r Princess Connect Re:Dive Japan:\t${Font_Red}Failed (Unexpected Result: $result)${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_PCRJP="Failed (Unexpected Result: $result)"
        fi
    else
        echo -n -e "\r Princess Connect Re:Dive Japan:\t${Font_Red}Failed (Unexpected Retval: $retval)${Font_Suffix}\n"
        LemonBench_Result_MediaUnlockTest_PCRJP="Failed (Unexpected Retval: $retval)"
    fi
}
