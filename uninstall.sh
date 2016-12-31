#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }
######Check Root#####

clear

bash /usr/local/SSR-Bash/ssadmin.sh stop >> /dev/null 2>&1

chkconfig --del shadowsocks
update-rc.d -f shadowsocks remove

rm -rf /usr/local/SSR-Bash/
rm -rf /usr/local/shadowsocks
rm -rf /usr/local/bin/ssr
rm -rf /etc/init.d/shadowsocksr

echo '卸载成功！'
