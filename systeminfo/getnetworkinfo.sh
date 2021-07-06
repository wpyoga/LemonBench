SystemInfo_GetNetworkInfo() {
    local Result_IPV4="$(curl --connect-timeout 10 -fsL4 https://api.ilemonrain.com/LemonBench/ipgeo.php)"
    local Result_IPV6="$(curl --connect-timeout 10 -fsL6 https://api.ilemonrain.com/LemonBench/ipgeo.php)"
    if [ "${Result_IPV4}" != "" ] && [ "${Result_IPV6}" = "" ]; then
        LBench_Result_NetworkStat="ipv4only"
    elif [ "${Result_IPV4}" = "" ] && [ "${Result_IPV6}" != "" ]; then
        LBench_Result_NetworkStat="ipv6only"
    elif [ "${Result_IPV4}" != "" ] && [ "${Result_IPV6}" != "" ]; then
        LBench_Result_NetworkStat="dualstack"
    else
        LBench_Result_NetworkStat="unknown"
    fi
    if [ "${LBench_Result_NetworkStat}" = "ipv4only" ] || [ "${LBench_Result_NetworkStat}" = "dualstack" ]; then
        IPAPI_IPV4_ip="$(PharseJSON "${Result_IPV4}" "ip")"
        IPAPI_IPV4_location="$(PharseJSON "${Result_IPV4}" "location")"
        IPAPI_IPV4_country_code="$(PharseJSON "${Result_IPV4}" "country_code")"
        IPAPI_IPV4_asn="$(PharseJSON "${Result_IPV4}" "asn")"
        IPAPI_IPV4_organization="$(PharseJSON "${Result_IPV4}" "organization")"
    fi
    if [ "${LBench_Result_NetworkStat}" = "ipv6only" ] || [ "${LBench_Result_NetworkStat}" = "dualstack" ]; then
        IPAPI_IPV6_ip="$(PharseJSON "${Result_IPV6}" "ip")"
        IPAPI_IPV6_location="$(PharseJSON "${Result_IPV6}" "location")"
        IPAPI_IPV6_country_code="$(PharseJSON "${Result_IPV6}" "country_code")"
        IPAPI_IPV6_asn="$(PharseJSON "${Result_IPV6}" "asn")"
        IPAPI_IPV6_organization="$(PharseJSON "${Result_IPV6}" "organization")"
    fi
    if [ "${LBench_Result_NetworkStat}" = "unknown" ]; then
        IPAPI_IPV4_ip="-"
        IPAPI_IPV4_location="-"
        IPAPI_IPV4_country_code="-"
        IPAPI_IPV4_asn="-"
        IPAPI_IPV4_organization="-"
        IPAPI_IPV6_ip="-"
        IPAPI_IPV6_location="-"
        IPAPI_IPV6_country_code="-"
        IPAPI_IPV6_asn="-"
        IPAPI_IPV6_organization="-"
    fi
}
