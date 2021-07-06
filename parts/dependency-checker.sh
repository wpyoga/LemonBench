# =============== 检查 Virt-what 组件 ===============
Check_Virtwhat() {
    if [ ! -f "/usr/sbin/virt-what" ]; then
        SystemInfo_GetOSRelease
        if [ "${Var_OSRelease}" = "centos" ] || [ "${Var_OSRelease}" = "rhel" ]; then
            echo -e "${Msg_Warning}Virt-What Module not found, Installing ..."
            yum -y install virt-what
        elif [ "${Var_OSRelease}" = "ubuntu" ] || [ "${Var_OSRelease}" = "debian" ]; then
            echo -e "${Msg_Warning}Virt-What Module not found, Installing ..."
            apt-get update
            apt-get install -y virt-what dmidecode
        elif [ "${Var_OSRelease}" = "fedora" ]; then
            echo -e "${Msg_Warning}Virt-What Module not found, Installing ..."
            dnf -y install virt-what
        elif [ "${Var_OSRelease}" = "alpinelinux" ]; then
            echo -e "${Msg_Warning}Virt-What Module not found, Installing ..."
            apk update
            apk add virt-what
        else
            echo -e "${Msg_Warning}Virt-What Module not found, but we could not find the os's release ..."
        fi
    fi
    # 二次检测
    if [ ! -f "/usr/sbin/virt-what" ]; then
        echo -e "Virt-What Moudle install Failure! Try Restart Bench or Manually install it! (/usr/sbin/virt-what)"
        exit 1
    fi
}

# =============== 检查 Speedtest 组件 ===============
Check_Speedtest() {
    if [ -f "/usr/local/lemonbench/bin/speedtest" ]; then
        chmod +x /usr/local/lemonbench/bin/speedtest >/dev/null 2>&1
        /usr/local/lemonbench/bin/speedtest --version >/dev/null 2>&1
        if [ "$?" = "0" ]; then
            return 0
        else
            rm -f /usr/local/lemonbench/bin/speedtest
            Check_Speedtest_GetComponent
        fi
    else
        Check_Speedtest_GetComponent
    fi
}

Check_Speedtest_GetComponent() {
    SystemInfo_GetOSRelease
    SystemInfo_GetSystemBit
    if [ "${LBench_Result_SystemBit_Full}" = "amd64" ]; then
        local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/Speedtest/1.0.0.2/speedtest-amd64.tar.gz"
    elif [ "${LBench_Result_SystemBit_Full}" = "i386" ]; then
        local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/Speedtest/1.0.0.2/speedtest-i386.tar.gz"
    elif [ "${LBench_Result_SystemBit_Full}" = "arm" ]; then
        local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/Speedtest/1.0.0.2/speedtest-arm.tar.gz"
    else
        local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/Speedtest/1.0.0.2/speedtest-i386.tar.gz"
    fi
    if [ "${Var_OSRelease}" = "centos" ] || [ "${Var_OSRelease}" = "rhel" ]; then
        echo -e "${Msg_Warning}Speedtest Module not found, Installing ..."
        echo -e "${Msg_Info}Installing Dependency ..."
        yum makecache fast
        yum -y install curl
        echo -e "${Msg_Info}Installing Speedtest Module ..."
        mkdir -p ${WorkDir}/.DownTmp >/dev/null 2>&1
        pushd ${WorkDir}/.DownTmp >/dev/null
        curl --user-agent "${UA_LemonBench}" ${DownloadSrc} -o ${WorkDir}/.DownTmp/speedtest.tar.gz
        tar xf ${WorkDir}/.DownTmp/speedtest.tar.gz
        mkdir -p /usr/local/lemonbench/bin/ >/dev/null 2>&1
        mv ${WorkDir}/.DownTmp/speedtest /usr/local/lemonbench/bin/
        chmod +x /usr/local/lemonbench/bin/speedtest
        echo -e "${Msg_Info}Cleaning up ..."
        popd >/dev/null
        rm -rf ${WorkDir}/.DownTmp
    elif [ "${Var_OSRelease}" = "ubuntu" ] || [ "${Var_OSRelease}" = "debian" ]; then
        echo -e "${Msg_Warning}Speedtest Module not found, Installing ..."
        echo -e "${Msg_Info}Installing Dependency ..."
        apt-get update
        apt-get --no-install-recommends -y install curl
        echo -e "${Msg_Info}Installing Speedtest Module ..."
        mkdir -p ${WorkDir}/.DownTmp >/dev/null 2>&1
        pushd ${WorkDir}/.DownTmp >/dev/null
        curl --user-agent "${UA_LemonBench}" ${DownloadSrc} -o ${WorkDir}/.DownTmp/speedtest.tar.gz
        tar xf ${WorkDir}/.DownTmp/speedtest.tar.gz
        mkdir -p /usr/local/lemonbench/bin/ >/dev/null 2>&1
        mv ${WorkDir}/.DownTmp/speedtest /usr/local/lemonbench/bin/
        chmod +x /usr/local/lemonbench/bin/speedtest
        echo -e "${Msg_Info}Cleaning up ..."
        popd >/dev/null
        rm -rf ${WorkDir}/.DownTmp
    elif [ "${Var_OSRelease}" = "fedora" ]; then
        echo -e "${Msg_Warning}Speedtest Module not found, Installing ..."
        echo -e "${Msg_Info}Installing Dependency ..."
        dnf -y install curl
        echo -e "${Msg_Info}Installing Speedtest Module ..."
        mkdir -p ${WorkDir}/.DownTmp >/dev/null 2>&1
        pushd ${WorkDir}/.DownTmp >/dev/null
        curl --user-agent "${UA_LemonBench}" ${DownloadSrc} -o ${WorkDir}/.DownTmp/speedtest.tar.gz
        tar xf ${WorkDir}/.DownTmp/speedtest.tar.gz
        mkdir -p /usr/local/lemonbench/bin/ >/dev/null 2>&1
        mv ${WorkDir}/.DownTmp/speedtest /usr/local/lemonbench/bin/
        chmod +x /usr/local/lemonbench/bin/speedtest
        echo -e "${Msg_Info}Cleaning up ..."
        popd >/dev/null
        rm -rf ${WorkDir}/.DownTmp
    elif [ "${Var_OSRelease}" = "alpinelinux" ]; then
        echo -e "${Msg_Warning}Speedtest Module not found, Installing ..."
        echo -e "${Msg_Info}Installing Dependency ..."
        apk update
        apk add curl
        echo -e "${Msg_Info}Installing Speedtest Module ..."
        mkdir -p ${WorkDir}/.DownTmp >/dev/null 2>&1
        pushd ${WorkDir}/.DownTmp >/dev/null
        curl --user-agent "${UA_LemonBench}" ${DownloadSrc} -o ${WorkDir}/.DownTmp/speedtest.tar.gz
        tar xf ${WorkDir}/.DownTmp/speedtest.tar.gz
        mkdir -p /usr/local/lemonbench/bin/ >/dev/null 2>&1
        mv ${WorkDir}/.DownTmp/speedtest /usr/local/lemonbench/bin/
        chmod +x /usr/local/lemonbench/bin/speedtest
        echo -e "${Msg_Info}Cleaning up ..."
        popd >/dev/null
        rm -rf ${WorkDir}/.DownTmp
    else
        echo -e "${Msg_Warning}Speedtest Module not found, trying direct download ..."
        mkdir -p ${WorkDir}/.DownTmp >/dev/null 2>&1
        pushd ${WorkDir}/.DownTmp >/dev/null
        curl --user-agent "${UA_LemonBench}" ${DownloadSrc} -o ${WorkDir}/.DownTmp/speedtest.tar.gz
        tar xf ${WorkDir}/.DownTmp/speedtest.tar.gz
        mkdir -p /usr/local/lemonbench/bin/ >/dev/null 2>&1
        mv ${WorkDir}/.DownTmp/speedtest /usr/local/lemonbench/bin/
        chmod +x /usr/local/lemonbench/bin/speedtest
        echo -e "${Msg_Info}Cleaning up ..."
        popd >/dev/null
        rm -rf ${WorkDir}/.DownTmp
    fi
    /usr/local/lemonbench/bin/speedtest --version >/dev/null 2>&1
    if [ "$?" != "0" ]; then
        echo -e "Speedtest Moudle install Failure! Try Restart Bench or Manually install it!"
        exit 1
    fi
}

# =============== 检查 BestTrace 组件 ===============
Check_BestTrace() {
    if [ ! -f "/usr/local/lemonbench/bin/besttrace" ]; then
        SystemInfo_GetOSRelease
        SystemInfo_GetSystemBit
        if [ "${LBench_Result_SystemBit_Full}" = "amd64" ]; then
            local BinaryName="besttrace64"
            local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/BestTrace/besttrace64.tar.gz"
            # local DownloadSrc="https://raw.githubusercontent.com/LemonBench/LemonBench/master/Resources/BestTrace/besttrace64.tar.gz"
        elif [ "${LBench_Result_SystemBit_Full}" = "i386" ]; then
            local BinaryName="besttrace32"
            local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/BestTrace/besttrace32.tar.gz"
            # local DownloadSrc="https://raw.githubusercontent.com/LemonBench/LemonBench/master/Resources/BestTrace/besttrace32.tar.gz"
        elif [ "${LBench_Result_SystemBit_Full}" = "arm" ]; then
            local BinaryName="besttracearm"
            local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/BestTrace/besttracearm.tar.gz"
            # local DownloadSrc="https://raw.githubusercontent.com/LemonBench/LemonBench/master/Resources/BestTrace/besttracearm.tar.gz"
        else
            local BinaryName="besttrace32"
            local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/BestTrace/besttrace32.tar.gz"
            # local DownloadSrc="https://raw.githubusercontent.com/LemonBench/LemonBench/master/Resources/BestTrace/besttrace32.tar.gz"
        fi
        mkdir -p ${WorkDir}/ >/dev/null 2>&1
        mkdir -p /usr/local/lemonbench/bin/ >/dev/null 2>&1
        if [ "${Var_OSRelease}" = "centos" ] || [ "${Var_OSRelease}" = "rhel" ]; then
            echo -e "${Msg_Warning}BestTrace Module not found, Installing ..."
            echo -e "${Msg_Info}Installing Dependency ..."
            yum -y install curl unzip
            echo -e "${Msg_Info}Downloading BestTrace Module ..."
            curl --user-agent "${UA_LemonBench}" ${DownloadSrc} -o ${WorkDir}/besttrace.tar.gz
            echo -e "${Msg_Info}Installing BestTrace Module ..."
            pushd ${WorkDir} >/dev/null
            tar xf besttrace.tar.gz
            mv ${BinaryName} /usr/local/lemonbench/bin/besttrace
            chmod +x /usr/local/lemonbench/bin/besttrace
            popd >/dev/null
            echo -e "${Msg_Info}Cleaning up ..."
            rm -rf ${WorkDir}/besttrace.tar.gz
        elif [ "${Var_OSRelease}" = "ubuntu" ] || [ "${Var_OSRelease}" = "debian" ]; then
            echo -e "${Msg_Warning}BestTrace Module not found, Installing ..."
            echo -e "${Msg_Info}Installing Dependency ..."
            apt-get update
            apt-get --no-install-recommends -y install wget unzip curl ca-certificates
            echo -e "${Msg_Info}Downloading BestTrace Module ..."
            curl --user-agent "${UA_LemonBench}" ${DownloadSrc} -o ${WorkDir}/besttrace.tar.gz
            echo -e "${Msg_Info}Installing BestTrace Module ..."
            pushd ${WorkDir} >/dev/null
            tar xf besttrace.tar.gz
            mv ${BinaryName} /usr/local/lemonbench/bin/besttrace
            chmod +x /usr/local/lemonbench/bin/besttrace
            popd >/dev/null
            echo -e "${Msg_Info}Cleaning up ..."
            rm -rf ${WorkDir}/besttrace.tar.gz
        elif [ "${Var_OSRelease}" = "fedora" ]; then
            echo -e "${Msg_Warning}BestTrace Module not found, Installing ..."
            echo -e "${Msg_Info}Installing Dependency ..."
            dnf -y install wget unzip curl
            echo -e "${Msg_Info}Downloading BestTrace Module ..."
            curl  --user-agent "${UA_LemonBench}" ${DownloadSrc} -o ${WorkDir}/besttrace.tar.gz
            echo -e "${Msg_Info}Installing BestTrace Module ..."
            pushd ${WorkDir} >/dev/null
            tar xf besttrace.tar.gz
            mv ${BinaryName} /usr/local/lemonbench/bin/besttrace
            chmod +x /usr/local/lemonbench/bin/besttrace
            popd >/dev/null
            echo -e "${Msg_Info}Cleaning up ..."
            rm -rf ${WorkDir}/besttrace.tar.gz
        elif [ "${Var_OSRelease}" = "alpinelinux" ]; then
            echo -e "${Msg_Warning}BestTrace Module not found, Installing ..."
            echo -e "${Msg_Info}Installing Dependency ..."
            apk update
            apk add wget unzip curl
            echo -e "${Msg_Info}Downloading BestTrace Module ..."
            curl --user-agent "${UA_LemonBench}" ${DownloadSrc} -o ${WorkDir}/besttrace.tar.gz
            echo -e "${Msg_Info}Installing BestTrace Module ..."
            pushd ${WorkDir} >/dev/null
            tar xf besttrace.tar.gz
            mv ${BinaryName} /usr/local/lemonbench/bin/besttrace
            chmod +x /usr/local/lemonbench/bin/besttrace
            popd >/dev/null
            echo -e "${Msg_Info}Cleaning up ..."
            rm -rf ${WorkDir}/besttrace.tar.gz
        else
            echo -e "${Msg_Warning}BestTrace Module not found, but we could not find the os's release ..."
        fi
    fi
    # 二次检测
    if [ ! -f "/usr/local/lemonbench/bin/besttrace" ]; then
        echo -e "BestTrace Moudle install Failure! Try Restart Bench or Manually install it! (/usr/local/lemonbench/bin/besttrace)"
        exit 1
    fi
}

# =============== 检查 JSON Query 组件 ===============
Check_JSONQuery() {
    if [ ! -f "/usr/bin/jq" ]; then
        SystemInfo_GetOSRelease
        SystemInfo_GetSystemBit
        if [ "${LBench_Result_SystemBit_Short}" = "64" ]; then
            local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/JSONQuery/jq-amd64.tar.gz"
            # local DownloadSrc="https://raw.githubusercontent.com/LemonBench/LemonBench/master/Resources/JSONQuery/jq-amd64.tar.gz"
            # local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/jq/1.6/amd64/jq.tar.gz"
        elif [ "${LBench_Result_SystemBit_Short}" = "32" ]; then
            local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/JSONQuery/jq-i386.tar.gz"
            # local DownloadSrc="https://raw.githubusercontent.com/LemonBench/LemonBench/master/Resources/JSONQuery/jq-i386.tar.gz"
            # local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/jq/1.6/i386/jq.tar.gz"
        else
            local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/JSONQuery/jq-i386.tar.gz"
            # local DownloadSrc="https://raw.githubusercontent.com/LemonBench/LemonBench/master/Resources/JSONQuery/jq-i386.tar.gz"
            # local DownloadSrc="https://raindrop.ilemonrain.com/LemonBench/include/jq/1.6/i386/jq.tar.gz"
        fi
        mkdir -p ${WorkDir}/
        if [ "${Var_OSRelease}" = "centos" ] || [ "${Var_OSRelease}" = "rhel" ]; then
            echo -e "${Msg_Warning}JSON Query Module not found, Installing ..."
            echo -e "${Msg_Info}Installing Dependency ..."
            yum install -y epel-release
            yum install -y jq
        elif [ "${Var_OSRelease}" = "ubuntu" ] || [ "${Var_OSRelease}" = "debian" ]; then
            echo -e "${Msg_Warning}JSON Query Module not found, Installing ..."
            echo -e "${Msg_Info}Installing Dependency ..."
            apt-get update
            apt-get install -y jq
        elif [ "${Var_OSRelease}" = "fedora" ]; then
            echo -e "${Msg_Warning}JSON Query Module not found, Installing ..."
            echo -e "${Msg_Info}Installing Dependency ..."
            dnf install -y jq
        elif [ "${Var_OSRelease}" = "alpinelinux" ]; then
            echo -e "${Msg_Warning}JSON Query Module not found, Installing ..."
            echo -e "${Msg_Info}Installing Dependency ..."
            apk update
            apk add jq
        else
            echo -e "${Msg_Warning}JSON Query Module not found, Installing ..."
            echo -e "${Msg_Info}Installing Dependency ..."
            apk update
            apk add wget unzip curl
            echo -e "${Msg_Info}Downloading Json Query Module ..."
            curl --user-agent "${UA_LemonBench}" ${DownloadSrc} -o ${WorkDir}/jq.tar.gz
            echo -e "${Msg_Info}Installing JSON Query Module ..."
            tar xvf ${WorkDir}/jq.tar.gz
            mv ${WorkDir}/jq /usr/bin/jq
            chmod +x /usr/bin/jq
            echo -e "${Msg_Info}Cleaning up ..."
            rm -rf ${WorkDir}/jq.tar.gz
        fi
    fi
    # 二次检测
    if [ ! -f "/usr/bin/jq" ]; then
        echo -e "JSON Query Moudle install Failure! Try Restart Bench or Manually install it! (/usr/bin/jq)"
        exit 1
    fi
}

# =============== 检查 Spoofer 组件 ===============
Check_Spoofer() {
    # 如果是快速模式启动, 则跳过Spoofer相关检查及安装
    if [ "${Global_TestMode}" = "fast" ] || [ "${Global_TestMode}" = "full" ]; then
        return 0
    fi
    # 检测是否存在已安装的Spoofer模块
    if [ -f "/usr/local/bin/spoofer-prober" ]; then
        return 0
    else
        echo -e "${Msg_Warning}Spoof Module not found, Installing ..."
        Check_Spoofer_PreBuild
    fi
    # 如果预编译安装失败了, 则开始编译安装
    if [ ! -f "/usr/local/bin/spoofer-prober" ]; then
        echo -e "${Msg_Warning}Spoof Module with Pre-Build Failed, trying complie ..."
        Check_Spoofer_InstantBuild
    fi
    # 如果编译安装仍然失败, 则停止运行
    if [ ! -f "/usr/local/bin/spoofer-prober" ]; then
        echo -e "${Msg_Error}Spoofer Moudle install Failure! Try Restart Bench or Manually install it! (/usr/local/bin/spoofer-prober)"
        exit 1
    fi
}

Check_Spoofer_PreBuild() {
    # 获取系统信息
    SystemInfo_GetOSRelease
    SystemInfo_GetSystemBit
    # 判断CentOS分支
    if [ "${Var_OSRelease}" = "centos" ] || [ "${Var_OSRelease}" = "rhel" ]; then
        local SysRel="centos"
        # 判断系统位数
        if [ "${LBench_Result_SystemBit}" = "i386" ]; then
            local SysBit="i386"
        elif [ "${LBench_Result_SystemBit}" = "amd64" ]; then
            local SysBit="amd64"
        else
            local SysBit="unknown"
        fi
        # 判断版本号
        if [ "${Var_CentOSELRepoVersion}" = "6" ]; then
            local SysVer="6"
        elif [ "${Var_CentOSELRepoVersion}" = "7" ]; then
            local SysVer="7"
        else
            local SysVer="unknown"
        fi
    # 判断Debian分支
    elif [ "${Var_OSRelease}" = "debian" ]; then
        local SysRel="debian"
        # 判断系统位数
        if [ "${LBench_Result_SystemBit}" = "i386" ]; then
            local SysBit="i386"
        elif [ "${LBench_Result_SystemBit}" = "amd64" ]; then
            local SysBit="amd64"
        else
            local SysBit="unknown"
        fi
        # 判断版本号
        if [ "${Var_OSReleaseVersion_Short}" = "8" ]; then
            local SysVer="8"
        elif [ "${Var_OSReleaseVersion_Short}" = "9" ]; then
            local SysVer="9"
        else
            local SysVer="unknown"
        fi
    # 判断Ubuntu分支
    elif [ "${Var_OSRelease}" = "ubuntu" ]; then
        local SysRel="ubuntu"
        # 判断系统位数
        if [ "${LBench_Result_SystemBit}" = "i386" ]; then
            local SysBit="i386"
        elif [ "${LBench_Result_SystemBit}" = "amd64" ]; then
            local SysBit="amd64"
        else
            local SysBit="unknown"
        fi
        # 判断版本号
        if [ "${Var_OSReleaseVersion_Short}" = "14.04" ]; then
            local SysVer="14.04"
        elif [ "${Var_OSReleaseVersion_Short}" = "16.04" ]; then
            local SysVer="16.04"
        elif [ "${Var_OSReleaseVersion_Short}" = "18.04" ]; then
            local SysVer="18.04"
        elif [ "${Var_OSReleaseVersion_Short}" = "18.10" ]; then
            local SysVer="18.10"
        elif [ "${Var_OSReleaseVersion_Short}" = "19.04" ]; then
            local SysVer="19.04"
        else
            local SysVer="unknown"
        fi
    fi
    if [ "${SysBit}" = "i386" ] && [ "${SysVer}" != "unknown" ]; then
        echo -e "${Msg_Warning}Pre-Build current does not support 32-bit system, starting compile process ..."
        Check_Spoofer_InstantBuild
    fi
    if [ "${SysBit}" = "unknown" ] || [ "${SysVer}" = "unknown" ]; then
        echo -e "${Msg_Warning}无法确认当前系统的版本号及位数, 或目前暂不支持预编译组件！"
    else
        if [ "${SysRel}" = "centos" ]; then
            echo -e "${Msg_Info}Release Detected: ${SysRel} ${SysVer} ${SysBit}"
            echo -e "${Msg_Info}Installing Dependency"
            yum install -y epel-release
            yum install -y protobuf-devel libpcap-devel openssl-devel traceroute wget curl
            local Spoofer_Version="$(curl  --user-agent "${UA_LemonBench}" -fskSL https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/latest_version)"
            echo -e "${Msg_Info}Downloading Spoof Module (Version ${Spoofer_Version}) ..."
            mkdir -p /tmp/_LBench/src/
            wget -U "${UA_LemonBench}" -O /tmp/_LBench/src/spoofer-prober.gz https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/${Spoofer_Version}/${SysRel}/${SysVer}/${SysBit}/spoofer-prober.gz
            echo -e "${Msg_Info}Installing Spoof Module ..."
            tar xf /tmp/_LBench/src/spoofer-prober.gz
            cp -f /tmp/_LBench/src/spoofer-prober /usr/local/bin/spoofer-prober
            chmod +x /usr/local/bin/spoofer-prober
            echo -e "${Msg_Info}Cleaning up ..."
            rm -f /tmp/_LBench/src/spoofer-prober.tar.gz
            rm -f /tmp/_LBench/src/spoofer-prober
        elif [ "${SysRel}" = "ubuntu" ] || [ "${SysRel}" = "debian" ]; then
            echo -e "${Msg_Info}Release Detected: ${SysRel} ${SysVer} ${SysBit}"
            echo -e "${Msg_Info}Installing Dependency"
            apt-get update
            apt-get install --no-install-recommends -y ca-certificates libprotobuf-dev libpcap-dev traceroute wget curl
            local Spoofer_Version="$(curl  --user-agent "${UA_LemonBench}" -fskSL https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/latest_version)"
            echo -e "${Msg_Info}Downloading Spoof Module (Version ${Spoofer_Version}) ..."
            mkdir -p /tmp/_LBench/src/
            wget -U "${UA_LemonBench}" -O /tmp/_LBench/src/spoofer-prober.gz https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/${Spoofer_Version}/${SysRel}/${SysVer}/${SysBit}/spoofer-prober.gz
            echo -e "${Msg_Info}Installing Spoof Module ..."
            tar xf /tmp/_LBench/src/spoofer-prober.gz
            cp -f /tmp/_LBench/src/spoofer-prober /usr/local/bin/spoofer-prober
            chmod +x /usr/local/bin/spoofer-prober
            echo -e "${Msg_Info}Cleaning up ..."
            rm -f /tmp/_LBench/src/spoofer-prober.tar.gz
            rm -f /tmp/_LBench/src/spoofer-prober
        else
            echo -e "${Msg_Warning}We cannot figure out the system bit or os release, so we cannot use the pre-build module！"
        fi
    fi
}

Check_Spoofer_InstantBuild() {
    SystemInfo_GetOSRelease
    SystemInfo_GetCPUInfo
    if [ "${Var_OSRelease}" = "centos" ] || [ "${Var_OSRelease}" = "rhel" ]; then
        echo -e "${Msg_Info}Release Detected: ${Var_OSRelease}"
        echo -e "${Msg_Info}Preparing compile enviorment ..."
        yum install -y epel-release
        yum install -y wget curl make gcc gcc-c++ traceroute openssl-devel protobuf-devel bison flex libpcap-devel
        local Spoofer_Version="$(curl  --user-agent "${UA_LemonBench}"  -fskSL https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/latest_version)"
        echo -e "${Msg_Info}Downloading Source code (Version ${Spoofer_Version})..."
        mkdir -p /tmp/_LBench/src/
        wget -U "${UA_LemonBench}" -O /tmp/_LBench/src/spoofer.tar.gz https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/${Spoofer_Version}/spoofer.tar.gz
        echo -e "${Msg_Info}Compiling Spoof Module ..."
        cd /tmp/_LBench/src/
        tar xvf spoofer.tar.gz && cd spoofer-"${Spoofer_Version}"
        # 测试性补丁
        wget -U "${UA_LemonBench}" -O /tmp/_LBench/src/configure.patch https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/${Spoofer_Version}/patch/configure.patch
        patch -p0 configure /tmp/_LBench/src/configure.patch
        ./configure && make -j ${LBench_Result_CPUThreadNumber}
        cp prober/spoofer-prober /usr/local/bin/spoofer-prober
        echo -e "${Msg_Info}Cleaning up ..."
        cd /tmp && rm -rf /tmp/_LBench/src/spoofer*
    elif [ "${Var_OSRelease}" = "ubuntu" ] || [ "${Var_OSRelease}" = "debian" ]; then
        echo -e "${Msg_Info}Release Detected: ${Var_OSRelease}"
        echo -e "${Msg_Info}Preparing compile enviorment ..."
        apt-get update
        apt-get install -y --no-install-recommends wget curl gcc g++ make traceroute protobuf-compiler libpcap-dev libprotobuf-dev openssl libssl-dev ca-certificates
        local Spoofer_Version="$(curl --user-agent "${UA_LemonBench}" -fskSL https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/latest_version)"
        echo -e "${Msg_Info}Downloading Source code (Version ${Spoofer_Version})..."
        mkdir -p /tmp/_LBench/src/
        wget -U "${UA_LemonBench}" -O /tmp/_LBench/src/spoofer.tar.gz https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/${Spoofer_Version}/spoofer.tar.gz
        echo -e "${Msg_Info}Compiling Spoof Module ..."
        cd /tmp/_LBench/src/
        tar xvf spoofer.tar.gz && cd spoofer-"${Spoofer_Version}"
        # 测试性补丁
        wget -U "${UA_LemonBench}" -O /tmp/_LBench/src/configure.patch https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/${Spoofer_Version}/patch/configure.patch
        patch -p0 configure /tmp/_LBench/src/configure.patch
        ./configure && make -j ${LBench_Result_CPUThreadNumber}
        cp prober/spoofer-prober /usr/local/bin/spoofer-prober
        echo -e "${Msg_Info}Cleaning up ..."
        cd /tmp && rm -rf /tmp/_LBench/src/spoofer*
    elif [ "${Var_OSRelease}" = "fedora" ]; then
        echo -e "${Msg_Info}Release Detected: ${Var_OSRelease}"
        echo -e "${Msg_Info}Preparing compile enviorment ..."
        dnf install -y wget curl make gcc gcc-c++ traceroute openssl-devel protobuf-devel bison flex libpcap-devel
        local Spoofer_Version="$(curl --user-agent "${UA_LemonBench}" -fskSL https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/latest_version)"
        echo -e "${Msg_Info}Downloading Source code (Version ${Spoofer_Version})..."
        mkdir -p /tmp/_LBench/src/
        wget -U "${UA_LemonBench}" -O /tmp/_LBench/src/spoofer.tar.gz https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/${Spoofer_Version}/spoofer.tar.gz
        echo -e "${Msg_Info}Compiling Spoof Module ..."
        cd /tmp/_LBench/src/
        tar xvf spoofer.tar.gz && cd spoofer-"${Spoofer_Version}"
        # 测试性补丁
        wget -U "${UA_LemonBench}" -O /tmp/_LBench/src/configure.patch https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/${Spoofer_Version}/patch/configure.patch
        patch -p0 configure /tmp/_LBench/src/configure.patch
        ./configure && make -j ${LBench_Result_CPUThreadNumber}
        cp prober/spoofer-prober /usr/local/bin/spoofer-prober
        echo -e "${Msg_Info}Cleaning up ..."
        cd /tmp && rm -rf /tmp/_LBench/src/spoofer*
    elif [ "${Var_OSRelease}" = "alpinelinux" ]; then
        echo -e "${Msg_Info}Release Detected: ${Var_OSRelease}"
        echo -e "${Msg_Info}Preparing compile enviorment ..."
        apk update
        apk add traceroute gcc g++ make openssl-dev protobuf-dev libpcap-dev
        local Spoofer_Version="$(curl  --user-agent "${UA_LemonBench}"  -fskSL https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/latest_version)"
        echo -e "${Msg_Info}Downloading Source code (Version ${Spoofer_Version})..."
        mkdir -p /tmp/_LBench/src/
        wget -U "${UA_LemonBench}" -O /tmp/_LBench/src/spoofer.tar.gz https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/${Spoofer_Version}/spoofer.tar.gz
        echo -e "${Msg_Info}Compiling Spoof Module ..."
        cd /tmp/_LBench/src/
        tar xvf spoofer.tar.gz && cd spoofer-"${Spoofer_Version}"
        # 测试性补丁
        wget -U "${UA_LemonBench}" -O /tmp/_LBench/src/configure.patch https://raindrop.ilemonrain.com/LemonBench/include/Spoofer/${Spoofer_Version}/patch/configure.patch
        patch -p0 configure /tmp/_LBench/src/configure.patch
        ./configure && make -j ${LBench_Result_CPUThreadNumber}
        cp prober/spoofer-prober /usr/local/bin/spoofer-prober
        echo -e "${Msg_Info}Cleaning up ..."
        cd /tmp && rm -rf /tmp/_LBench/src/spoofer*
    else
        echo -e "${Msg_Error}Cannot compile on current enviorment！ (Only Support CentOS/Debian/Ubuntu/Fedora/AlpineLinux) "
    fi
}

# =============== 检查 SysBench 组件 ===============
Check_SysBench() {
    if [ ! -f "/usr/bin/sysbench" ] && [ ! -f "/usr/local/bin/sysbench" ]; then
        SystemInfo_GetOSRelease
        SystemInfo_GetSystemBit
        if [ "${Var_OSRelease}" = "centos" ] || [ "${Var_OSRelease}" = "rhel" ]; then
            echo -e "${Msg_Warning}Sysbench Module not found, installing ..."
            yum -y install epel-release
            yum -y install sysbench
        elif [ "${Var_OSRelease}" = "ubuntu" ]; then
            echo -e "${Msg_Warning}Sysbench Module not found, installing ..."
            apt-get install -y sysbench
        elif [ "${Var_OSRelease}" = "debian" ]; then
            echo -e "${Msg_Warning}Sysbench Module not found, installing ..."
            local mirrorbase="https://raindrop.ilemonrain.com/LemonBench"
            local componentname="Sysbench"
            local version="1.0.19-1"
            local arch="debian"
            local codename="${Var_OSReleaseVersion_Codename}"
            local bit="${LBench_Result_SystemBit_Full}"
            local filenamebase="sysbench"
            local filename="${filenamebase}_${version}_${bit}.deb"
            local downurl="${mirrorbase}/include/${componentname}/${version}/${arch}/${codename}/${filename}"
            mkdir -p ${WorkDir}/download/
            pushd ${WorkDir}/download/ >/dev/null
            wget -U "${UA_LemonBench}" -O ${filenamebase}_${version}_${bit}.deb ${downurl}
            dpkg -i ./${filename}
            apt-get install -f -y
            popd
            if [ ! -f "/usr/bin/sysbench" ] && [ ! -f "/usr/local/bin/sysbench" ]; then
                echo -e "${Msg_Warning}Sysbench Module Install Failed!"
            fi
        elif [ "${Var_OSRelease}" = "fedora" ]; then
            echo -e "${Msg_Warning}Sysbench Module not found, installing ..."
            dnf -y install sysbench
        elif [ "${Var_OSRelease}" = "alpinelinux" ]; then
            echo -e "${Msg_Warning}Sysbench Module not found, installing ..."
            echo -e "${Msg_Warning}SysBench Current not support Alpine Linux, Skipping..."
            Var_Skip_SysBench="1"
        fi
    fi
    # 垂死挣扎 (尝试编译安装)
    if [ ! -f "/usr/bin/sysbench" ] && [ ! -f "/usr/local/bin/sysbench" ]; then
        echo -e "${Msg_Warning}Sysbench Module install Failure, trying compile modules ..."
        Check_Sysbench_InstantBuild
    fi
    # 最终检测
    if [ ! -f "/usr/bin/sysbench" ] && [ ! -f "/usr/local/bin/sysbench" ]; then
        echo -e "${Msg_Error}SysBench Moudle install Failure! Try Restart Bench or Manually install it! (/usr/bin/sysbench)"
        exit 1
    fi
}

Check_Sysbench_InstantBuild() {
    SystemInfo_GetOSRelease
    SystemInfo_GetCPUInfo
    if [ "${Var_OSRelease}" = "centos" ] || [ "${Var_OSRelease}" = "rhel" ]; then
        echo -e "${Msg_Info}Release Detected: ${Var_OSRelease}"
        echo -e "${Msg_Info}Preparing compile enviorment ..."
        yum install -y epel-release
        yum install -y wget curl make gcc gcc-c++ make automake libtool pkgconfig libaio-devel
        echo -e "${Msg_Info}Release Detected: ${Var_OSRelease}"
        echo -e "${Msg_Info}Downloading Source code (Version 1.0.17)..."
        mkdir -p /tmp/_LBench/src/
        wget -U "${UA_LemonBench}" -O /tmp/_LBench/src/sysbench.zip https://github.com/akopytov/sysbench/archive/1.0.17.zip
        echo -e "${Msg_Info}Compiling Sysbench Module ..."
        cd /tmp/_LBench/src/
        unzip sysbench.zip && cd sysbench-1.0.17
        ./autogen.sh && ./configure --without-mysql && make -j8 && make install
        echo -e "${Msg_Info}Cleaning up ..."
        cd /tmp && rm -rf /tmp/_LBench/src/sysbench*
    elif [ "${Var_OSRelease}" = "ubuntu" ] || [ "${Var_OSRelease}" = "debian" ]; then
        echo -e "${Msg_Info}Release Detected: ${Var_OSRelease}"
        echo -e "${Msg_Info}Preparing compile enviorment ..."
        apt-get update
        apt -y install --no-install-recommends curl wget make automake libtool pkg-config libaio-dev unzip
        echo -e "${Msg_Info}Downloading Source code (Version 1.0.17)..."
        mkdir -p /tmp/_LBench/src/
        wget -U "${UA_LemonBench}" -O /tmp/_LBench/src/sysbench.zip https://github.com/akopytov/sysbench/archive/1.0.17.zip
        echo -e "${Msg_Info}Compiling Sysbench Module ..."
        cd /tmp/_LBench/src/
        unzip sysbench.zip && cd sysbench-1.0.17
        ./autogen.sh && ./configure --without-mysql && make -j8 && make install
        echo -e "${Msg_Info}Cleaning up ..."
        cd /tmp && rm -rf /tmp/_LBench/src/sysbench*
    elif [ "${Var_OSRelease}" = "fedora" ]; then
        echo -e "${Msg_Info}Release Detected: ${Var_OSRelease}"
        echo -e "${Msg_Info}Preparing compile enviorment ..."
        dnf install -y wget curl gcc gcc-c++ make automake libtool pkgconfig libaio-devel
        echo -e "${Msg_Info}Downloading Source code (Version 1.0.17)..."
        mkdir -p /tmp/_LBench/src/
        wget -U "${UA_LemonBench}" -O /tmp/_LBench/src/sysbench.zip https://github.com/akopytov/sysbench/archive/1.0.17.zip
        echo -e "${Msg_Info}Compiling Sysbench Module ..."
        cd /tmp/_LBench/src/
        unzip sysbench.zip && cd sysbench-1.0.17
        ./autogen.sh && ./configure --without-mysql && make -j8 && make install
        echo -e "${Msg_Info}Cleaning up ..."
        cd /tmp && rm -rf /tmp/_LBench/src/sysbench*
    else
        echo -e "${Msg_Error}Cannot compile on current enviorment！ (Only Support CentOS/Debian/Ubuntu/Fedora) "
    fi
}

Function_CheckTracemode() {
    if [ "${Flag_TracerouteModeisSet}" = "1" ]; then
        if [ "${GlobalVar_TracerouteMode}" = "icmp" ]; then
            echo -e "${Msg_Info}Traceroute/BestTrace Tracemode is set to: ${Font_SkyBlue}ICMP Mode${Font_Suffix}"
        elif [ "${GlobalVar_TracerouteMode}" = "tcp" ]; then
            echo -e "${Msg_Info}Traceroute/BestTrace Tracemode is set to: ${Font_SkyBlue}TCP Mode${Font_Suffix}"
        fi
    else
        GlobalVar_TracerouteMode="tcp"
    fi
}
