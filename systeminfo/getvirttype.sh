SystemInfo_GetVirtType() {
    if [ -f "/usr/bin/systemd-detect-virt" ]; then
        Var_VirtType="$(/usr/bin/systemd-detect-virt)"
        # 虚拟机检测
        if [ "${Var_VirtType}" = "qemu" ]; then
            LBench_Result_VirtType="QEMU"
        elif [ "${Var_VirtType}" = "kvm" ]; then
            LBench_Result_VirtType="KVM"
        elif [ "${Var_VirtType}" = "zvm" ]; then
            LBench_Result_VirtType="S390 Z/VM"
        elif [ "${Var_VirtType}" = "vmware" ]; then
            LBench_Result_VirtType="VMware"
        elif [ "${Var_VirtType}" = "microsoft" ]; then
            LBench_Result_VirtType="Microsoft Hyper-V"
        elif [ "${Var_VirtType}" = "xen" ]; then
            LBench_Result_VirtType="Xen Hypervisor"
        elif [ "${Var_VirtType}" = "bochs" ]; then
            LBench_Result_VirtType="BOCHS"   
        elif [ "${Var_VirtType}" = "uml" ]; then
            LBench_Result_VirtType="User-mode Linux"   
        elif [ "${Var_VirtType}" = "parallels" ]; then
            LBench_Result_VirtType="Parallels"   
        elif [ "${Var_VirtType}" = "bhyve" ]; then
            LBench_Result_VirtType="FreeBSD Hypervisor"
        # 容器虚拟化检测
        elif [ "${Var_VirtType}" = "openvz" ]; then
            LBench_Result_VirtType="OpenVZ"
        elif [ "${Var_VirtType}" = "lxc" ]; then
            LBench_Result_VirtType="LXC"        
        elif [ "${Var_VirtType}" = "lxc-libvirt" ]; then
            LBench_Result_VirtType="LXC (libvirt)"        
        elif [ "${Var_VirtType}" = "systemd-nspawn" ]; then
            LBench_Result_VirtType="Systemd nspawn"        
        elif [ "${Var_VirtType}" = "docker" ]; then
            LBench_Result_VirtType="Docker"        
        elif [ "${Var_VirtType}" = "rkt" ]; then
            LBench_Result_VirtType="RKT"
        # 特殊处理
        elif [ -c "/dev/lxss" ]; then # 处理WSL虚拟化
            Var_VirtType="wsl"
            LBench_Result_VirtType="Windows Subsystem for Linux (WSL)"
        # 未匹配到任何结果, 或者非虚拟机 
        elif [ "${Var_VirtType}" = "none" ]; then
            Var_VirtType="dedicated"
            LBench_Result_VirtType="None"
            local Var_BIOSVendor="$(dmidecode -s bios-vendor)"
            if [ "${Var_BIOSVendor}" = "SeaBIOS" ]; then
                Var_VirtType="Unknown"
                LBench_Result_VirtType="Unknown with SeaBIOS BIOS"
            else
                Var_VirtType="dedicated"
                LBench_Result_VirtType="Dedicated with ${Var_BIOSVendor} BIOS"
            fi
        fi
    elif [ ! -f "/usr/sbin/virt-what" ]; then
        Var_VirtType="Unknown"
        LBench_Result_VirtType="[Error: virt-what not found !]"
    elif [ -f "/.dockerenv" ]; then # 处理Docker虚拟化
        Var_VirtType="docker"
        LBench_Result_VirtType="Docker"
    elif [ -c "/dev/lxss" ]; then # 处理WSL虚拟化
        Var_VirtType="wsl"
        LBench_Result_VirtType="Windows Subsystem for Linux (WSL)"
    else # 正常判断流程
        Var_VirtType="$(virt-what | xargs)"
        local Var_VirtTypeCount="$(echo $Var_VirtTypeCount | wc -l)"
        if [ "${Var_VirtTypeCount}" -gt "1" ]; then # 处理嵌套虚拟化
            LBench_Result_VirtType="echo ${Var_VirtType}"
            Var_VirtType="$(echo ${Var_VirtType} | head -n1)" # 使用检测到的第一种虚拟化继续做判断
        elif [ "${Var_VirtTypeCount}" -eq "1" ] && [ "${Var_VirtType}" != "" ]; then # 只有一种虚拟化
            LBench_Result_VirtType="${Var_VirtType}"
        else
            local Var_BIOSVendor="$(dmidecode -s bios-vendor)"
            if [ "${Var_BIOSVendor}" = "SeaBIOS" ]; then
                Var_VirtType="Unknown"
                LBench_Result_VirtType="Unknown with SeaBIOS BIOS"
            else
                Var_VirtType="dedicated"
                LBench_Result_VirtType="Dedicated with ${Var_BIOSVendor} BIOS"
            fi
        fi
    fi
}
