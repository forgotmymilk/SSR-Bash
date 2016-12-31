#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }
######Check Root#####
clear
bash /usr/local/SSR-Bash/ssadmin.sh stop
rm -rf /usr/local/SSR-Bash/
rm -rf /usr/local/shadowsocks
rm -rf /usr/local/bin/ssr
rm -rf /etc/init.d/shadowsocksr
update-rc.d -f shadowsocksr remove
echo '卸载成功！'
