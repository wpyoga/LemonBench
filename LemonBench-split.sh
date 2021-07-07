#!/bin/bash
#
# #------------------------------------------------------------------#
# |   LemonBench 服务器测试工具      LemonBench Server Test Utility   |
# #------------------------------------------------------------------#
# | Written by iLemonrain <ilemonrain@ilemonrain.com>                |
# | My Blog: https://ilemonrain.com                                  |
# | Telegram: https://t.me/ilemonrain                                |
# | Telegram (For +86 User): https://t.me/ilemonrain_chatbot         |
# | Telegram Channel: https://t.me/ilemonrain_channel                |
# #------------------------------------------------------------------#
# | If you like this project, feel free to donate!                   |
# | 如果你喜欢这个项目, 欢迎投喂打赏！                                  |
# |                                                                  |
# | Donate Method 打赏方式:                                          |
# | Alipay QR Code: http://t.cn/EA3pZNt                              |
# | 支付宝二维码:http://t.cn/EA3pZNt                                 |
# | Wechat QR Code: http://t.cn/EA3p639                              |
# | 微信二维码: http://t.cn/EA3p639                                   |
# #------------------------------------------------------------------#
#
# 使用方法 (任选其一):
# (1) wget -O- https://ilemonrain.com/download/shell/LemonBench.sh | bash
# (2) curl -fsL https://ilemonrain.com/download/shell/LemonBench.sh | bash
#
# === 全局定义 =====================================

# @MERGE
. init/global-variables.sh

# @MERGE
. init/text-colors.sh

# =================================================

# === 全局模块 =====================================

# @MERGE
. init/signal-traps.sh

# @MERGE
. components/util-functions.sh

# @MERGE
. components/global-actions.sh

# ==================================================

# =============== -> 主程序开始 <- ==================

# @MERGE
. components/systeminfo.sh

# @MERGE
. components/benchmark-announcer-functions.sh

# @MERGE
. components/streaming-media-unlock.sh

# @MERGE
. components/network-speedtest.sh

# @MERGE
. components/disk-benchmarks.sh

# @MERGE
. components/network-besttrace.sh

# @MERGE
. components/spoofer-functions.sh

# @MERGE
. components/sysbench-cpu.sh

# @MERGE
. components/sysbench-memory.sh

# @MERGE
. components/result-generator.sh

# @MERGE
. components/dependency-checker.sh

# @MERGE
. components/main-functions.sh

# @MERGE
. components/parse-arguments.sh
# @MERGE
. components/select-mode.sh
