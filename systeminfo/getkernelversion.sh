SystemInfo_GetKernelVersion() {
    local version="$(uname -r)"
    LBench_Result_KernelVersion="${version}"
}
