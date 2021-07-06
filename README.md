> This project was forked from [LemonBench/LemonBench](https://github.com/LemonBench/LemonBench) and subsequently modularized. In order to build the main distributable script, the modular script files are merged using [merge-shell](https://github.com/wpyoga/merge-shell).
>
> This `faithful-fork` branch produces a 1:1 reproduction of `LemonBench.sh` as `LemonBench-merged.sh`. You can use the `Makefile` to test the faithfulness of this reproduction.

# LemonBench - Linux Server Benchmark Toolkit

Current Version: 20200426 Intl BetaVersion



- LemonBench v2 coming soon :)

- This version (20200426) of LemonBench v1 is the final Functional Update. It may not update to any new version if there is not any critical issues or configuration failure.



LemonBench is a simple Linux Server Evaluation & Benchmark Toolkit, written in Shell Script.

This simple tool can test linux server/vps performance in about 10 minutes, and gerenate a report, which can share to others.

Currently, LemonBench supports ```i386/i686```, ```x86_64```, ```armel/armhf```, ```arm64/aarch64``` architectures, and support CentOS / Debian / Ubuntu / Fedora / Raspbian OS.

Feel free for PR, and good issues, and please add stars and donate if you feel it is a good tool !



### Current Support Features

- System Information (OS Release Info / CPU Info / Virt Info / Memory Info / Disk Info / Load Info etc.)
- Network Information (IPV4 IP Address, ASN Info, Geo Info / IPV6 IP Address, ASN Info, Geo Info)
- Streaming Unlock Test (HBO Now, BBC, Princess Connect Re:Dive! Japan Server, Bahamut Anime, Bilibili HongKong/Macau/Taiwan)
- CPU Performance Test (Based on Sysbench 1.0.19)
- Memory Performance Test (Based on Sysbench 1.0.19)
- Disk Performance Test (4K Block / 1M Block)
- Speedtest.net Network Speed Test
- Traceroute Test (Server -> Primary ISP)
- Spoof Test (need manually activate)
- Auto-Generate Result and Sharing
