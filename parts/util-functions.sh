# 简易JSON解析器 (Deprecated)
# PharseJSON() {
#    # 使用方法: PharseJSON "要解析的原JSON文本" "要解析的键值"
#    # Example: PharseJSON ""Value":"123456"" "Value" [返回结果: 123456]
#    echo -n $1 | grep -oP '(?<='$2'":)[0-9A-Za-z]+'
#    if [ "$?" = "1" ]; then
#        echo -n $1 | grep -oP ''$2'[" :]+\K[^"]+'
#        if [ "$?" = "1" ]; then
#            echo -n "null"
#            return 1
#        fi
#    fi
#}

# 新版JSON解析
PharseJSON() {
    # 使用方法: PharseJSON "要解析的原JSON文本" "要解析的键值"
    # Example: PharseJSON ""Value":"123456"" "Value" [返回结果: 123456]
    echo -n $1 | jq -r .$2
}

# Ubuntu PasteBin 提交工具
# 感谢 @metowolf 提供思路
PasteBin_Upload() {
    local uploadresult="$(curl -fsL -X POST \
        --url https://paste.ubuntu.com \
        --output /dev/null \
        --write-out "%{url_effective}\n" \
        --data-urlencode "content@${PASTEBIN_CONTENT:-/dev/stdin}" \
        --data "poster=${PASTEBIN_POSTER:-LemonBench}" \
        --data "expiration=${PASTEBIN_EXPIRATION:-}" \
        --data "syntax=${PASTEBIN_SYNTAX:-text}")"
    if [ "$?" = "0" ]; then
        echo -e "${Msg_Success}Report Generate Success！Please save the follwing link:"
        echo -e "${Msg_Info}Report URL: ${uploadresult}"
    else
        echo -e "${Msg_Warning}Report Generate Failure, But you can still read $HOME/LemonBench.Result.txt to get this result！"
    fi
}

# 读取配置文件
ReadConfig() {
    # 使用方法: ReadConfig <配置文件> <读取参数>
    # Example: ReadConfig "/etc/config.cfg" "Parameter"
    cat $1 | sed '/^'$2'=/!d;s/.*=//'
}
