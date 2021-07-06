#  =============== 流媒体解锁测试 部分 ===============

# 流媒体解锁测试
Function_MediaUnlockTest() {
    echo -e " "
    echo -e "${Font_Yellow} -> Media Unlock Test ${Font_Suffix}"
    echo -e " "
    Function_MediaUnlockTest_HBONow
    Function_MediaUnlockTest_BahamutAnime
    Function_MediaUnlockTest_AbemaTV_IPTest
    Function_MediaUnlockTest_PCRJP
    #Function_MediaUnlockTest_IQiYi_Taiwan
    Function_MediaUnlockTest_BBC
    Function_MediaUnlockTest_BilibiliChinaMainland
    Function_MediaUnlockTest_BilibiliHKMCTW
    Function_MediaUnlockTest_BilibiliTW
    LBench_Flag_FinishMediaUnlockTest="1"
}

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

# 流媒体解锁测试-哔哩哔哩港澳台限定
Function_MediaUnlockTest_BilibiliHKMCTW() {
    echo -n -e " BiliBili Hongkong/Macau/Taiwan:\t->\c"
    local randsession="$(cat /dev/urandom | head -n 32 | md5sum | head -c 32)"
    # 尝试获取成功的结果
    local result="$(curl --user-agent "${UA_Browser}" -4 -fsL --max-time 30 "https://api.bilibili.com/pgc/player/web/playurl?avid=18281381&cid=29892777&qn=0&type=&otype=json&ep_id=183799&fourk=1&fnver=0&fnval=16&session=${randsession}&module=bangumi")"
    if [ "$?" = "0" ]; then
        local result="$(PharseJSON "${result}" "code")"
        if [ "$?" = "0" ]; then
            if [ "${result}" = "0" ]; then
                echo -n -e "\r BiliBili Hongkong/Macau/Taiwan:\t${Font_Green}Yes${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_BilibiliHKMCTW="Yes"
            elif [ "${result}" = "-10403" ]; then
                echo -n -e "\r BiliBili Hongkong/Macau/Taiwan:\t${Font_Red}No${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_BilibiliHKMCTW="No"
            else
                echo -n -e "\r BiliBili Hongkong/Macau/Taiwan:\t${Font_Red}Failed (due to unknown return)${Font_Suffix} ${Font_SkyBlue}(${result})${Font_Suffix}\n"
                LemonBench_Result_MediaUnlockTest_BilibiliHKMCTW="Failed (due to unknown return)" 
            fi
        else
            echo -n -e "\r BiliBili Hongkong/Macau/Taiwan:\t${Font_Red}Failed (due to parse fail)${Font_Suffix}\n"
            LemonBench_Result_MediaUnlockTest_BilibiliHKMCTW="Failed (due to parse fail)"
        fi
    else
        echo -n -e "\r BiliBili Hongkong/Macau/Taiwan:\t${Font_Red}Failed (due to network fail)${Font_Suffix}\n"
        LemonBench_Result_MediaUnlockTest_BilibiliHKMCTW="Failed (due to network fail)"        
    fi   
}

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
