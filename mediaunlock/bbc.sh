Function_MediaUnlockTest_BBC() {
    local result="$(curl --user-agent "${UA_Browser}" -4 -fsL --write-out %{http_code} --max-time 30 --output /dev/null http://ve-dash-uk.live.cf.md.bbci.co.uk/)"
    if [ "$?" = "0" ]; then
        if [ "${result}" = "403" ] || [ "${result}" = "000" ]; then
            echo -n -e "\r BBC:\t\t\t\t\t${Font_Red}No${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_BBC="No"
        elif [ "${result}" = "404" ]; then
            echo -n -e "\r BBC:\t\t\t\t\t${Font_Green}Yes${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_BBC="Yes"
        else
            echo -n -e "\r BBC:\t\t\t\t\t${Font_Red}Failed (Unexpected Result: $result)${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_BBC="Failed (Unexpected Result: $result)"
        fi
    else
        echo -n -e "\r BBC:\t\t\t\t\t${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
        LemonBench_Result_MediaUnlockTest_BBC="Failed (Network Connection)"
    fi
}
