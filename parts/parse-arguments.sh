# =============== 命令行参数 ===============
# 检测传入参数
SingleTestCount="0"
while [[ $# -ge 1 ]]; do
    case $1 in
    mode | -mode | --mode | testmode | -testmode | --testmode)
        shift
        if [ "${GlobalVar_TestMode}" != "" ]; then
            echo -e "\n${Msg_Error}只允许同时启用一种预置测试! 请检查输入参数后重试!"
            Entrance_HelpDocument
            exit 1
        else
            GlobalVar_TestMode="$1"
            shift
        fi
        ;;
    # 快速测试
    fast | -fast | --fast)
        shift
        if [ "${GlobalVar_TestMode}" != "" ]; then
            echo -e "\n${Msg_Error}只允许同时启用一种预置测试! 请检查输入参数后重试!"
            Entrance_HelpDocument
            exit 1
        else
            GlobalVar_TestMode="fast"
        fi
        ;;
    # 完整测试
    full | -full | --full)
        shift
        if [ "${GlobalVar_TestMode}" != "" ]; then
            echo -e "\n${Msg_Error}只允许同时启用一种预置测试! 请检查输入参数后重试!"
            Entrance_HelpDocument
            exit 1
        else
            GlobalVar_TestMode="full"
        fi
        ;;
    # 流媒体解锁测试
    mlt | -mlt | --mlt)
        shift
        GlobalVar_TestMode="mediaunlocktest"
        ;;
    # 磁盘测试
    dtfast | -dtfast | --dtfast)
        shift
        GlobalVar_TestMode="disktest-fast"
        ;;
    dtfull | -dtfull | --dtfull)
        shift
        GlobalVar_TestMode="disktest-full"
        ;;
    # Speedtest测试
    spfast | -spfast | --spfast)
        shift
        GlobalVar_TestMode="speedtest-fast"
        ;;
    spfull | -spfull | --spfull)
        shift
        GlobalVar_TestMode="speedtest-full"
        ;;
    # 路由追踪测试        
    btfast | -btfast | --btfast | trfast | -trfast | --trfast)
        shift
        GlobalVar_TestMode="besttrace-fast"
        ;;
    btfull | -btfull | --btfull | trfull | -trull | --trfull)
        shift
        GlobalVar_TestMode="besttrace-full"
        ;;
    # Spoof测试
    spf | -spf | --spf | spoof | -spoof | --spoof | spoofer | -spoofer | --spoofer)
        shift
        GlobalVar_TestMode="spoof"
        ;;
    # CPU测试
    sbcfast | -sbcfast | --sbcfast)
        shift
        GlobalVar_TestMode="sysbench-cpu-fast"
        ;;
    sbcfull | -sbcfull | --sbcfull)
        shift
        GlobalVar_TestMode="sysbench-cpu-full"
        ;;
    # 内存测试
    sbmfast | -sbmfast | --sbmfast)
        shift
        GlobalVar_TestMode="sysbench-memory-fast"
        ;;
    sbmfull | -sbmfull | --sbmfull)
        shift
        GlobalVar_TestMode="sysbench-memory-full"
        ;;
    # 路由追踪测试模式
    tracemode | -tracemode | --tracemode )
        shift
        if [ "$1" = "icmp" ]; then
            Flag_TracerouteModeisSet="1"
            GlobalVar_TracerouteMode="icmp"
            shift
        elif [ "$1" = "tcp" ]; then
            Flag_TracerouteModeisSet="1"
            GlobalVar_TracerouteMode="tcp"
            shift
        else
            Flag_TracerouteModeisSet="0"
            GlobalVar_TracerouteMode="tcp"
            shift
        fi
        ;;
    # 帮助文档
    h | -h | --h | help | -help | --help)
        Entrance_HelpDocument
        exit 1
        ;;
    # 无效参数处理
    *)
        [[ "$1" != 'error' ]] && echo -ne "\n${Msg_Error}Invalid Parameters: \"$1\"\n"
        Entrance_HelpDocument
        exit 1
        ;;
    esac
done
