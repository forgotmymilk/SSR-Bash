#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
#Disable China
wget http://iscn.kirito.moe/run.sh
. ./run.sh
if [[ $area == cn ]];then
echo "Unable to install in china"
exit
fi
#Check Root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

while :; do echo
		read -p "是否使用最新版脚本？（y/n）： " ifusenewversion
		if [[ ! $ifusenewversion =~ ^[y,n]$ ]]; then
			echo "输入错误! 请输入y或者n!"
		else
			break
		fi
done

if [[ $ifusenewversion == 'y' ]];then
    wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/SSR-Bash-Python/master/install.sh && bash install.sh
    exit
else
	read -p "输入（我确定使用旧版脚本，并且不会向项目管理员递交任何错误报告）： " ifold
	if [[ $ifold == '我确定使用旧版脚本，并且不会向项目管理员递交任何错误报告' ]];then
	#Set DNS
	echo "nameserver 8.8.8.8" > /etc/resolv.conf
	echo "nameserver 8.8.4.4" >> /etc/resolv.conf

	#Disable selinux
	if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then
 	   sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
 	   setenforce 0
	fi

	clear

	#InstallBasicPackages
	apt-get update -y
	apt-get install git tar python unzip bc wget unzip perl curl cron ntpdate ntp build-essential -y
	apt-get install language-pack-zh-hans -y


	#Clone Something
	cd /usr/local
	git clone https://github.com/FunctionClub/shadowsocksr
	mv shadowsocksr shadowsocks
	git clone https://github.com/FunctionClub/SSR-Bash

	#Intall libsodium
	cd /root
	wget --no-check-certificate -O libsodium-1.0.10.tar.gz https://github.com/jedisct1/libsodium/releases/download/1.0.10/libsodium-1.0.10.tar.gz
	tar -xf libsodium-1.0.10.tar.gz && cd libsodium-1.0.10
	./configure && make && make install
	echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf && ldconfig
	cd ../ && rm -rf libsodium* 

	#Update NTP settings
	rm -rf /etc/localtime
	ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	service ntp stop
	ntpdate us.pool.ntp.org
	service ntp start

	#InstallCrontab
	echo '1 1 * * * /usr/local/SSR-Bash/ssadmin.sh restart >> /dev/null 2>&1' >> /var/spool/cron/crontabs/root ##Restart ShadowsocksR Server at 01.01 a.m
	echo '1 1 1 * * /usr/local/SSR-Bash/ssadmin.sh reset_all_used >> /dev/null 2>&1' >> /var/spool/cron/crontabs/root ##Clean user bandwith monthly
	service cron restart

	#Install ssr-chkconfig
	wget -N --no-check-certificate -O /etc/init.d/shadowsocksr https://raw.githubusercontent.com/FunctionClub/SSR-Bash/master/ssr-chkconfig
	chmod +x /etc/init.d/shadowsocksr
	update-rc.d -f shadowsocksr defaults


	#Install Softlink
	mv /usr/local/SSR-Bash/ssr /usr/local/bin/
	chmod +x /usr/local/bin/ssr



	echo '安装完成！输入 ssr 即可使用本程序~'
	echo '由于使用旧版脚本，不现实支持信息'
fi
fi

