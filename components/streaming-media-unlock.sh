#  =============== 流媒体解锁测试 部分 ===============

# 流媒体解锁测试
Function_MediaUnlockTest() {
    echo -e " "
    echo -e "${Font_Yellow} -> Media Unlock Test ${Font_Suffix}"
    echo -e " "
    Function_MediaUnlockTest_HBONow
    Function_MediaUnlockTest_BahamutAnime
    Function_MediaUnlockTest_AbemaTV_IPTest
    Function_MediaUnlockTest_PCRJP
    #Function_MediaUnlockTest_IQiYi_Taiwan
    Function_MediaUnlockTest_BBC
    Function_MediaUnlockTest_BilibiliChinaMainland
    Function_MediaUnlockTest_BilibiliHKMCTW
    Function_MediaUnlockTest_BilibiliTW
    LBench_Flag_FinishMediaUnlockTest="1"
}

# @MERGE
. mediaunlock/hbonow.sh

# @MERGE
. mediaunlock/bahamutanime.sh

# @MERGE
. mediaunlock/bilibili-chinamainland.sh

# @MERGE
. mediaunlock/bilibili-hkmctw.sh

# @MERGE
. mediaunlock/bilibili-tw.sh

# @MERGE
. mediaunlock/iqiyi-taiwan.sh

# @MERGE
. mediaunlock/abematv.sh

# @MERGE
. mediaunlock/pcr-jp.sh

# @MERGE
. mediaunlock/bbc.sh
