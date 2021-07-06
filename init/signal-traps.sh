# Trap终止信号捕获
trap "Global_TrapSigExit_Sig1" 1
trap "Global_TrapSigExit_Sig2" 2
trap "Global_TrapSigExit_Sig3" 3
trap "Global_TrapSigExit_Sig15" 15

# Trap终止信号1 - 处理
Global_TrapSigExit_Sig1() {
    echo -e "\n\n${Msg_Error}Caught Signal SIGHUP, Exiting ...\n"
    Global_TrapSigExit_Action
    exit 1
}

# Trap终止信号2 - 处理 (Ctrl+C)
Global_TrapSigExit_Sig2() {
    echo -e "\n\n${Msg_Error}Caught Signal SIGINT (or Ctrl+C), Exiting ...\n"
    Global_TrapSigExit_Action
    exit 1
}

# Trap终止信号3 - 处理
Global_TrapSigExit_Sig3() {
    echo -e "\n\n${Msg_Error}Caught Signal SIGQUIT, Exiting ...\n"
    Global_TrapSigExit_Action
    exit 1
}

# Trap终止信号15 - 处理 (进程被杀)
Global_TrapSigExit_Sig15() {
    echo -e "\n\n${Msg_Error}Caught Signal SIGTERM, Exiting ...\n"
    Global_TrapSigExit_Action
    exit 1
}
