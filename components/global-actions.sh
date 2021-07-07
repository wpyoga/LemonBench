# 程序启动动作
Global_StartupInit_Action() {
    Global_Startup_Header
    echo -e "${Msg_Info}Loaded Testmode:${Font_SkyBlue}${Global_TestModeTips}${Font_Suffix}"
    Function_CheckTracemode
    # 清理残留, 为新一次的运行做好准备
    echo -e "${Msg_Info}Initializing Running Enviorment, Please wait ..."
    rm -rf ${WorkDir}
    rm -rf /.tmp_LBench/
    mkdir ${WorkDir}/
    echo -e "${Msg_Info}Checking Dependency ..."
    Check_Virtwhat
    Check_JSONQuery
    Check_Speedtest
    Check_BestTrace
    Check_Spoofer
    Check_SysBench
    echo -e "${Msg_Info}Starting Test ...\n\n"
    clear
}



Global_Exit_Action() {
    rm -rf ${WorkDir}/
}

# 捕获异常信号后的动作
Global_TrapSigExit_Action() {
    rm -rf ${WorkDir}
    rm -rf /.tmp_LBench/
}
