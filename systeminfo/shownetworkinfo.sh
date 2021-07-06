Function_ShowNetworkInfo() {
    echo -e "\n ${Font_Yellow}-> Network Infomation${Font_Suffix}\n"
    if [ "${LBench_Result_NetworkStat}" = "ipv4only" ] || [ "${LBench_Result_NetworkStat}" = "dualstack" ]; then
        if [ "${IPAPI_IPV4_ip}" != "" ]; then
            echo -e " ${Font_Yellow}IPV4 - IP Address:${Font_Suffix}\t${Font_SkyBlue}[${IPAPI_IPV4_country_code}] ${IPAPI_IPV4_ip}${Font_Suffix}"
            echo -e " ${Font_Yellow}IPV4 - ASN Info:${Font_Suffix}\t${Font_SkyBlue}${IPAPI_IPV4_asn} (${IPAPI_IPV4_organization})${Font_Suffix}"
            echo -e " ${Font_Yellow}IPV4 - Region:${Font_Suffix}\t\t${Font_SkyBlue}${IPAPI_IPV4_location}${Font_Suffix}"
        else
            echo -e " ${Font_Yellow}IPV6 - IP Address:${Font_Suffix}\t${Font_Red}Error: API Query Failed${Font_Suffix}"
        fi
    fi
    if [ "${LBench_Result_NetworkStat}" = "ipv6only" ] || [ "${LBench_Result_NetworkStat}" = "dualstack" ]; then
        if [ "${IPAPI_IPV6_ip}" != "" ]; then
            echo -e " ${Font_Yellow}IPV6 - IP Address:${Font_Suffix}\t${Font_SkyBlue}[${IPAPI_IPV6_country_code}] ${IPAPI_IPV6_ip}${Font_Suffix}"
            echo -e " ${Font_Yellow}IPV6 - ASN Info:${Font_Suffix}\t${Font_SkyBlue}${IPAPI_IPV6_asn} (${IPAPI_IPV6_organization})${Font_Suffix}"
            echo -e " ${Font_Yellow}IPV6 - Region:${Font_Suffix}\t\t${Font_SkyBlue}${IPAPI_IPV6_location}${Font_Suffix}"
        else
            echo -e " ${Font_Yellow}IPV6 - IP Address:${Font_Suffix}\t${Font_Red}Error: API Query Failed${Font_Suffix}"
        fi
    fi
    # 执行完成, 标记FLAG
    LBench_Flag_FinishNetworkInfo="1"
}
