Function_SpooferTest() {
    if [ "${Var_SpooferDisabled}" = "1" ]; then
        return 0
    fi
    mkdir -p ${WorkDir}/Spoofer/ >/dev/null 2>&1
    echo -e "\n ${Font_Yellow}-> Spoof Test${Font_Suffix}\n"
    echo -e "\n -> Spoof Test\n" >>${WorkDir}/Spoofer/result.txt
    Check_Spoofer
    mkdir ${WorkDir}/ >/dev/null 2>&1
    echo -e "Running Spoof Test, this may take a long time, please wait ..."
    /usr/local/bin/spoofer-prober -s0 -r0 | tee -a ${WorkDir}/spoofer.log >/dev/null
    if [ "$?" = "0" ]; then
        LBench_Result_SpooferResultURL="$(cat ${WorkDir}/spoofer.log | grep -oE "https://spoofer.caida.org/report.php\?sessionkey\=[0-9a-z]{1,}")"
        echo -e "\n ${Msg_Success}Spoofer Result:${LBench_Result_SpooferResultURL}"
        echo -e "\n Spoofer Result:${LBench_Result_SpooferResultURL}" >>${WorkDir}/Spoofer/result.txt
        LBench_Flag_FinishSpooferTest="1"
    else
        cp -f ${WorkDir}/spoofer.log /tmp/lemonbench.spoofer.log
        echo -e "\n ${Msg_Error}Spoofer Test Fail! Please read /tmp/lemonbench.spoofer.log to view logs !"
        echo -e "\n Spoofer Result:Fail" >>${WorkDir}/Spoofer/result.txt
        LBench_Flag_FinishSpooferTest="2"
    fi
    rm -rf ${WorkDir}/spoofer.log
    # 执行完成, 标记FLAG
    sleep 1
}

Function_SpooferWarning() {
    echo -e " "
    echo -e "\e[33;43;1m  Please Read this FIRST  \e[0m"
    echo -e " "
    echo -e " Due to some user report, running spoof test may cause server suspendsion by your host provider."
    echo -e " Please use this function with caution."
    echo -e " "
    echo -e " If you still want to start this test, you can press any key to continue, else press Ctrl+C to"
    echo -e " stop running this test."
    read -s -n1 -p ""
}
