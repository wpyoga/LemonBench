# 流媒体解锁测试-爱奇艺台湾站 (Neta)
#
#Function_MediaUnlockTest_IQiYi_Taiwan() {
#    echo -n -e " IQiYi Taiwan (Beta):\t\t\t->\c"
#    local result="$(curl --user-agent "${UA_Browser}" -4 -fsL --max-time 30 "https://cache.video.iqiyi.com/dash?tvid=15364711300&bid=300&vid=3413c5aaa8e04f3724633fb6a4b55c8f&src=01010031010010000000&vt=0&rs=1&uid=&ori=pcw&ps=0&k_uid=949b5c6e48ff7dd333256e186a4d4e64&pt=0&d=0&s=&lid=&cf=&ct=&authKey=d6daa842887706d98d34de38e2c35d94&k_tag=1&ost=0&ppt=0&dfp=a11b673840ba64405b8614ebe8dd6db591c1bd76c1a87d4e9f9305a19f33f87688&locale=zh_tw&prio=%7B%22ff%22%3A%22f4v%22%2C%22code%22%3A2%7D&pck=&k_err_retries=0&up=&qd_v=2&tm=1587902927410&qdy=a&qds=0&k_ft1=706436220846084&k_ft4=1099714535424&k_ft5=1&bop=%7B%22version%22%3A%2210.0%22%2C%22dfp%22%3A%22a11b673840ba64405b8614ebe8dd6db591c1bd76c1a87d4e9f9305a19f33f87688%22%7D&ut=0&vf=674989244c4748e4bf06f169b9eee540")"
#    if [ "$?" = "0" ]; then
#        local res_st="$(echo $result | jq -r .data.st)"
#        if [ "${res_st}" = "101" ]; then
#            echo -n -e "\r IQiYi Taiwan (Beta):\t\t\t${Font_Green}Yes${Font_Suffix}\n"
#            LemonBench_Result_MediaUnlockTest_IQiYi_Taiwan="Yes"
#        elif [ "${res_st}" = "502" ]; then
#            echo -n -e "\r IQiYi Taiwan (Beta):\t\t\t${Font_Red}No${Font_Suffix}\n"
#            LemonBench_Result_MediaUnlockTest_IQiYi_Taiwan="No"
#        else
#            echo -n -e "\r IQiYi Taiwan (Beta):\t\t\t${Font_Red}Failed (Unexpected Result: $result)${Font_Suffix}\n"
#            LemonBench_Result_MediaUnlockTest_IQiYi_Taiwan="Failed (Unexpected Result: $result)"
#        fi
#    else
#        echo -n -e "\r IQiYi Taiwan (Beta):\t\t\t${Font_Red}Failed (Network Connection)${Font_Suffix}\n"
#        LemonBench_Result_MediaUnlockTest_IQiYi_Taiwan="Failed (Network Connection)"
#    fi
#}
