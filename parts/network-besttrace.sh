# =============== BestTrace 部分 ===============
Run_BestTrace() {
    mkdir -p ${WorkDir}/BestTrace/ >/dev/null 2>&1
    # 调用方式: Run_BestTrace "目标IP" "ICMP/TCP" "最大跃点数" "说明"
    if [ "$2" = "tcp" ] || [ "$2" = "TCP" ]; then
        echo -e "Traceroute to $4 (TCP Mode, Max $3 Hop)"
        echo -e "============================================================"
        echo -e "\nTraceroute to $4 (TCP Mode, Max $3 Hop)" >>${WorkDir}/BestTrace/result.txt
        echo -e "============================================================" >>${WorkDir}/BestTrace/result.txt
        /usr/local/lemonbench/bin/besttrace -g en -q 1 -n -T -m $3 $1 | tee -a ${WorkDir}/BestTrace/result.txt
    else
        echo -e "Traceroute to $4 (ICMP Mode, Max $3 Hop)"
        echo -e "============================================================"
        echo -e "\nTracecroute to $4 (ICMP Mode, Max $3 Hop)" >>${WorkDir}/BestTrace/result.txt
        echo -e "============================================================" >>${WorkDir}/BestTrace/result.txt
        /usr/local/lemonbench/bin/besttrace -g en -q 1 -n -m $3 $1 | tee -a ${WorkDir}/BestTrace/result.txt
    fi
}

Run_BestTrace6() {
    # 调用方式: Run_BestTrace "目标IP" "ICMP/TCP" "最大跃点数" "说明"
    if [ "$2" = "tcp" ] || [ "$2" = "TCP" ]; then
        echo -e "Traceroute to $4 (TCP Mode, Max $3 Hop)"
        echo -e "============================================================"
        echo -e "\nTraceroute to $4 (TCP Mode, Max $3 Hop)" >>${WorkDir}/BestTrace/result.txt
        echo -e "============================================================" >>${WorkDir}/BestTrace/result.txt
        /usr/local/lemonbench/bin/besttrace -g en -6 -q 1 -n -T -m $3 $1 >>${WorkDir}/BestTrace/result.txt
    elif [ "$2" = "icmp" ] || [ "$2" = "ICMP" ]; then
        echo -e "Traceroute to $4 (ICMP Mode, Max $3 Hop)"
        echo -e "============================================================"
        echo -e "Traceroute to $4 (ICMP Mode, Max $3 Hop)" >>${WorkDir}/BestTrace/result.txt
        echo -e "============================================================" >>${WorkDir}/BestTrace/result.txt
        /usr/local/lemonbench/bin/besttrace -g en -6 -q 1 -n -m $3 $1 | tee -a ${WorkDir}/BestTrace/result.txt
    fi
}

Function_BestTrace_Fast() {
    Check_BestTrace
    mkdir -p ${WorkDir}/BestTrace/ >/dev/null 2>&1
    if [ "${LBench_Result_NetworkStat}" = "ipv4only" ] || [ "${LBench_Result_NetworkStat}" = "dualstack" ]; then
        echo -e "\n ${Font_Yellow}-> Traceroute Test (IPV4)${Font_Suffix}\n"
        echo -e "\n -> Traceroute Test (IPV4)\n" >>${WorkDir}/BestTrace/result.txt
        # LemonBench RouteTest 节点列表 Ver 20191112
        # 国内部分
        Run_BestTrace "123.125.99.1" "${GlobalVar_TracerouteMode}" "50" "China, Beijing CU"
        Run_BestTrace "180.149.128.9" "${GlobalVar_TracerouteMode}" "50" "China, Beijing CT"
        Run_BestTrace "211.136.25.153" "${GlobalVar_TracerouteMode}" "50" "China, Beijing CM"
        Run_BestTrace "58.247.8.158" "${GlobalVar_TracerouteMode}" "50" "China, Shanghai CU"
        Run_BestTrace "180.153.28.5" "${GlobalVar_TracerouteMode}" "50" "China, Shanghai CT"
        Run_BestTrace "221.183.55.22" "${GlobalVar_TracerouteMode}" "50" "China, Shanghai CM"
        Run_BestTrace "210.21.4.130" "${GlobalVar_TracerouteMode}" "50" "China, Guangzhou CU"
        Run_BestTrace "113.108.209.1" "${GlobalVar_TracerouteMode}" "50" "China, Guangzhou CT"
        Run_BestTrace "120.196.212.25" "${GlobalVar_TracerouteMode}" "50" "China, Guangzhou CM"
        Run_BestTrace "210.13.66.238" "${GlobalVar_TracerouteMode}" "50" "China, Shanghai CU AS9929"
        Run_BestTrace "58.32.0.1" "${GlobalVar_TracerouteMode}" "50" "China, Shanghai CT CN2"
        Run_BestTrace "14.131.128.1" "${GlobalVar_TracerouteMode}" "50" "China, Beijing Dr.Peng Home Network"
        Run_BestTrace "211.167.230.100" "${GlobalVar_TracerouteMode}" "50" "China, Beijing Dr.Peng Network IDC Network"
        Run_BestTrace "202.205.109.205" "${GlobalVar_TracerouteMode}" "50" "China, Beijing CERNET"
        Run_BestTrace "159.226.254.1" "${GlobalVar_TracerouteMode}" "50" "China, Beijing CSTNET"
        Run_BestTrace "211.156.140.17" "${GlobalVar_TracerouteMode}" "50" "China, Beijing GCable"
    fi
    if [ "${LBench_Result_NetworkStat}" = "ipv6only" ] || [ "${LBench_Result_NetworkStat}" = "dualstack" ]; then
        echo -e "\n ${Font_Yellow}-> Traceroute Test (IPV6)${Font_Suffix}\n"
        echo -e "\n -> Traceroute Test (IPV6)\n" >>${WorkDir}/BestTrace/result.txt
        Run_BestTrace6 "2408:80f0:4100:2005::3" "ICMP" "50" "China, Beijing CU IPV6"
        Run_BestTrace6 "240e:18:10:a01::1" "ICMP" "50" "China, Shanghai CT IPV6"
        Run_BestTrace6 "2409:8057:5c00:30::6" "ICMP" "50" "China, Guangzhou CM IPV6"
        Run_BestTrace6 "2001:da8:a0:1001::1" "ICMP" "50" "China, Beijing CERNET2 IPV6"
        Run_BestTrace6 "2400:dd00:0:37::213" "ICMP" "50" "China, Beijing CSTNET IPV6"
    fi
    # 执行完成, 标记FLAG
    LBench_Flag_FinishBestTraceFast="1"
    sleep 1
}

Function_BestTrace_Full() {
    Check_BestTrace
    mkdir -p ${WorkDir}/BestTrace/ >/dev/null 2>&1
    if [ "${LBench_Result_NetworkStat}" = "ipv4only" ] || [ "${LBench_Result_NetworkStat}" = "dualstack" ] || [ "${LBench_Result_NetworkStat}" = "unknown" ]; then
        echo -e "\n ${Font_Yellow}-> Traceroute Test (IPV4)${Font_Suffix}\n"
        echo -e "\n -> Traceroute Test (IPV4)\n" >>${WorkDir}/BestTrace/result.txt
        # LemonBench RouteTest 节点列表 Ver 20191112
        # 国内部分
        Run_BestTrace "123.125.99.1" "${GlobalVar_TracerouteMode}" "50" "China, Beijing CU"
        Run_BestTrace "180.149.128.1" "${GlobalVar_TracerouteMode}" "50" "China, Beijing CT"
        Run_BestTrace "211.136.25.153" "${GlobalVar_TracerouteMode}" "50" "China, Beijing CM"
        Run_BestTrace "58.247.0.49" "${GlobalVar_TracerouteMode}" "50" "China, Shanghai CU"
        Run_BestTrace "180.153.28.1" "${GlobalVar_TracerouteMode}" "50" "China, Shanghai CT"
        Run_BestTrace "221.183.55.22" "${GlobalVar_TracerouteMode}" "50" "China, Shanghai CM"
        Run_BestTrace "210.21.4.130" "${GlobalVar_TracerouteMode}" "50" "China, Guangzhou CU"
        Run_BestTrace "113.108.209.1" "${GlobalVar_TracerouteMode}" "50" "China, Guangzhou CT"
        Run_BestTrace "211.139.129.5" "${GlobalVar_TracerouteMode}" "50" "China, Guangzhou CM"
        Run_BestTrace "210.13.66.238" "${GlobalVar_TracerouteMode}" "50" "China, Shanghai CU AS9929"
        Run_BestTrace "58.32.0.1" "${GlobalVar_TracerouteMode}" "50" "China, Shanghai CT CN2"
        Run_BestTrace "14.131.128.1" "${GlobalVar_TracerouteMode}" "50" "China, Beijing Dr.Peng Home Network"
        Run_BestTrace "211.167.230.100" "${GlobalVar_TracerouteMode}" "50" "China, Beijing Dr.Peng Network IDC Network"
        Run_BestTrace "202.205.109.205" "${GlobalVar_TracerouteMode}" "50" "China, Beijing CERNET"
        Run_BestTrace "159.226.254.1" "${GlobalVar_TracerouteMode}" "50" "China, Beijing CSTNET"
        Run_BestTrace "211.156.140.17" "${GlobalVar_TracerouteMode}" "50" "China, Beijing GCable"
        # 香港部分
        Run_BestTrace "203.160.95.218" "${GlobalVar_TracerouteMode}" "50" "China, Hongkong CU"
        Run_BestTrace "203.215.232.173" "${GlobalVar_TracerouteMode}" "50" "China, Hongkong CT"
        Run_BestTrace "203.8.25.187" "${GlobalVar_TracerouteMode}" "50" "China, Hongkong CT CN2"
        Run_BestTrace "203.142.105.9" "${GlobalVar_TracerouteMode}" "50" "China, Hongkong CM"
        Run_BestTrace "218.188.104.30" "${GlobalVar_TracerouteMode}" "50" "China, Hongkong HGC"
        Run_BestTrace "210.6.23.239" "${GlobalVar_TracerouteMode}" "50" "China, Hongkong HKBN"
        Run_BestTrace "202.85.125.60" "${GlobalVar_TracerouteMode}" "50" "China, Hongkong PCCW"
        Run_BestTrace "202.123.76.239" "${GlobalVar_TracerouteMode}" "50" "China, Hongkong TGT"
        Run_BestTrace "59.152.252.242" "${GlobalVar_TracerouteMode}" "50" "China, Hongkong WTT"
        # 新加坡部分
        Run_BestTrace "203.215.233.1" "${GlobalVar_TracerouteMode}" "50" "Singapore, China CT"
        Run_BestTrace "183.91.61.1" "${GlobalVar_TracerouteMode}" "50" "Singapore, China CT CN2"
        Run_BestTrace "118.201.1.11" "${GlobalVar_TracerouteMode}" "50" "Singapore, Singtel"
        Run_BestTrace "203.116.46.33" "${GlobalVar_TracerouteMode}" "50" "Singapore, StarHub"
        Run_BestTrace "118.189.184.1" "${GlobalVar_TracerouteMode}" "50" "Singapore, M1"
        Run_BEstTrace "118.189.38.17" "${GlobalVar_TracerouteMode}" "50" "Singapore, M1 GamePro"
        Run_BestTrace "13.228.0.251" "${GlobalVar_TracerouteMode}" "50" "Singapore, AWS"
        # 日本部分
        Run_BestTrace "61.213.155.84" "${GlobalVar_TracerouteMode}" "50" "Japan, NTT"
        Run_BestTrace "202.232.15.70" "${GlobalVar_TracerouteMode}" "50" "Japan, IIJ"
        Run_BestTrace "210.175.32.26" "${GlobalVar_TracerouteMode}" "50" "Japan, SoftBank"
        Run_BestTrace "106.162.242.108" "${GlobalVar_TracerouteMode}" "50" "Japan, KDDI"
        Run_BestTrace "203.215.236.3" "${GlobalVar_TracerouteMode}" "50" "Japan, China CT"
        Run_BestTrace "202.55.27.4" "${GlobalVar_TracerouteMode}" "50" "Japan, China CT CN2"
        Run_BestTrace "13.112.63.251" "${GlobalVar_TracerouteMode}" "50" "Japan, Amazon AWS"
        # 韩国部分
        Run_BestTrace "210.114.41.101" "${GlobalVar_TracerouteMode}" "50" "South Korea, KT"
        Run_BestTrace "175.122.253.62 " "${GlobalVar_TracerouteMode}" "50" "South Korea, SK"
        Run_BestTrace "211.174.62.44" "${GlobalVar_TracerouteMode}" "50" "South Korea, LG"
        Run_BestTrace "218.185.246.3" "${GlobalVar_TracerouteMode}" "50" "South Korea, China CT CN2"
        Run_BestTrace "13.124.63.251" "${GlobalVar_TracerouteMode}" "50" "South Korea, Amazon AWS"
        # 台湾部分
        Run_BestTrace "202.133.242.116" "${GlobalVar_TracerouteMode}" "50" "China, Taiwan Chief"
        Run_BestTrace "210.200.69.90" "${GlobalVar_TracerouteMode}" "50" "China, Taiwan APTG"
        Run_BestTrace "203.75.129.162" "${GlobalVar_TracerouteMode}" "50" "China, Taiwan CHT"
        Run_BestTrace "219.87.66.3" "${GlobalVar_TracerouteMode}" "50" "China, Taiwan TFN"
        Run_BestTrace "211.73.144.38" "${GlobalVar_TracerouteMode}" "50" "China,Taiwan FET"
        Run_BestTrace "61.63.0.102" "${GlobalVar_TracerouteMode}" "50" "China, Taiwan KBT"
        Run_BestTrace "103.31.196.203" "${GlobalVar_TracerouteMode}" "50" "China, Taiwan TAIFO"
        # 美国部分
        Run_BestTrace "218.30.33.17" "${GlobalVar_TracerouteMode}" "50" "United States, Los Angeles China CT"
        Run_BestTrace "66.102.252.100" "${GlobalVar_TracerouteMode}" "50" "United States, Los Angeles China CT CN2"
        Run_BestTrace "63.218.42.81" "${GlobalVar_TracerouteMode}" "50" "United States, Los Angeles PCCW"
        Run_BestTrace "66.220.18.42" "${GlobalVar_TracerouteMode}" "50" "United States, Los Angeles HE"
        Run_BestTrace "173.205.77.98" "${GlobalVar_TracerouteMode}" "50" "United States, Los Angeles GTT"
        Run_BestTrace "12.169.215.33" "${GlobalVar_TracerouteMode}" "50" "United States, San Fransico ATT"
        Run_BestTrace "66.198.181.100" "${GlobalVar_TracerouteMode}" "50" "United States, New York TATA"
        Run_BestTrace "218.30.33.17" "${GlobalVar_TracerouteMode}" "50" "United States, San Jose China CT"
        Run_BestTrace "23.11.26.62" "${GlobalVar_TracerouteMode}" "50" "United States, San Jose NTT"
        Run_BestTrace "72.52.104.74" "${GlobalVar_TracerouteMode}" "50" "United States, Fremont HE"
        Run_BestTrace "205.216.62.38" "${GlobalVar_TracerouteMode}" "50" "United States, Las Vegas Level3"
        Run_BestTrace "64.125.191.31" "${GlobalVar_TracerouteMode}" "50" "United States, San Jose ZAYO"
        Run_BestTrace "149.127.109.166" "${GlobalVar_TracerouteMode}" "50" "United States, Ashburn Cogentco"
        # 欧洲部分
        Run_BestTrace "80.146.191.1" "${GlobalVar_TracerouteMode}" "50" "German, Telekom"
        Run_BestTrace "82.113.108.25" "${GlobalVar_TracerouteMode}" "50" "German, Frankfurt O2"
        Run_BestTrace "139.7.146.11" "${GlobalVar_TracerouteMode}" "50" "German, Frankfurt Vodafone"
        Run_BestTrace "118.85.205.101" "${GlobalVar_TracerouteMode}" "50" "German, Frankfurt China CT"
        Run_BestTrace "5.10.138.33" "${GlobalVar_TracerouteMode}" "50" "German, Frankfurt China CT CN2"
        Run_BestTrace "213.200.65.70" "${GlobalVar_TracerouteMode}" "50" "German, Frankfurt GTT"
        Run_BestTrace "212.20.150.5" "${GlobalVar_TracerouteMode}" "50" "German, FrankfurtCogentco"
        Run_BestTrace "194.62.232.211" "${GlobalVar_TracerouteMode}" "50" "United Kingdom, Vodafone"
        Run_BestTrace "213.121.43.24" "${GlobalVar_TracerouteMode}" "50" "United Kingdom， BT"
        Run_BestTrace "80.231.131.34" "${GlobalVar_TracerouteMode}" "50" "United Kingdom, London TATA"
        Run_BestTrace "118.85.205.181" "${GlobalVar_TracerouteMode}" "50" "Russia, China CT"
        Run_BestTrace "185.75.173.17" "${GlobalVar_TracerouteMode}" "50" "Russia, China CT CN2"
        Run_BestTrace "87.226.162.77" "${GlobalVar_TracerouteMode}" "50" "Russia, Moscow RT"
        Run_BestTrace "217.150.32.2" "${GlobalVar_TracerouteMode}" "50" "Russia, Moscow TTK"
        Run_BestTrace "195.34.32.71" "${GlobalVar_TracerouteMode}" "50" "Russia, Moscow MTS"
    fi
    if [ "${LBench_Result_NetworkStat}" = "ipv6only" ] || [ "${LBench_Result_NetworkStat}" = "dualstack" ] || [ "${LBench_Result_NetworkStat}" = "unknown" ]; then
        echo -e "\n ${Font_Yellow}-> Traceroute Test (IPV6)${Font_Suffix}\n"
        echo -e "\n -> Traceroute Test (IPV6)\n" >>${WorkDir}/BestTrace/result.txt
        # 国内部分
        Run_BestTrace6 "2408:80f0:4100:2005::3" "ICMP" "50" "China, Beijing CU IPV6"
        Run_BestTrace6 "2400:da00:2::29" "ICMP" "50" "China, Beijing CT IPV6"
        Run_BestTrace6 "2409:8089:1020:50ff:1000::fd01" "ICMP" "50" "China, Beijing CM IPV6"
        Run_BestTrace6 "2408:8000:9000:20e6::b7" "ICMP" "50" "China, Shanghai CU IPV6"
        Run_BestTrace6 "240e:18:10:a01::1" "ICMP" "50" "China, Shanghai CT IPV6"
        Run_BestTrace6 "2409:801e:5c03:2000::207" "ICMP" "50" "China, Shanghai CM IPV6"
        Run_BestTrace6 "2408:8001:3011:310::3" "ICMP" "50" "China, Guangzhou CU IPV6"
        Run_BestTrace6 "240e:ff:e02c:1:21::" "ICMP" "50" "China, Guangzhou CT IPV6"
        Run_BestTrace6 "2409:8057:5c00:30::6" "ICMP" "50" "China, Guangzhou CM IPV6"
        Run_BestTrace6 "2403:8880:400f::2" "ICMP" "50" "China, Beijing Dr.Peng IPV6"
        Run_BestTrace6 "2001:da8:a0:1001::1" "ICMP" "50" "China, Beijing CERNET2 IPV6"
        Run_BestTrace6 "2400:dd00:0:37::213" "ICMP" "50" "China, Beijing CSTNET IPV6"
        # 香港部分
        Run_BestTrace6 "2001:7fa:0:1::ca28:a1a9" "ICMP" "50" "China, Hongkong HKIX IPV6"
        Run_BestTrace6 "2001:470:0:490::2" "ICMP" "50" "China, Hongkong HE IPV6"
        # 美国部分
        Run_BestTrace6 "2001:470:1:ff::1" "ICMP" "50" "United States, San Jose HE IPV6"
        Run_BestTrace6 "2001:418:0:5000::1026" "ICMP" "50" "United States, Chicago NTT IPV6"
        Run_BestTrace6 "2001:2000:3080:1e96::2" "ICMP" "50" "United States, Los Angeles Telia IPV6"
        Run_BestTrace6 "2001:668:0:3:ffff:0:d8dd:9d5a" "ICMP" "50" "United States, Los Angeles GTT IPV6"
        Run_BestTrace6 "2600:0:1:1239:144:228:241:71" "ICMP" "50" "United States, Kansas City Sprint IPV6"
        Run_BestTrace6 "2600:80a:2::15" "ICMP" "50" "United States, Los Angeles Verizon IPV6"
        Run_BestTrace6 "2001:550:0:1000::9a36:4215" "ICMP" "50" "United Status, Ashburn Cogentco IPV6"
        Run_BestTrace6 "2001:1900:2100::2eb5" "ICMP" "50" "United States, San Jose Level3 IPV6"
        Run_BestTrace6 "2001:438:ffff::407d:d6a" "ICMP" "50" "United States, Seattle Zayo IPV6"
        # 欧洲部分
        Run_BestTrace6 "2001:470:0:349::1" "ICMP" "50" "France, Paris HE IPV6"
        Run_BestTrace6 "2001:728:0:5000::6f6" "ICMP" "50" "German, Frankfurt NTT IPV6"
    fi
    # 执行完成, 标记FLAG
    LBench_Flag_FinishBestTraceFull="1"
    sleep 1
}
