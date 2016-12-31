#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

#Check Root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }


#Check OS
if [ -f /etc/redhat-release ];then
	OS=CentOS
elif [ ! -z "`cat /etc/issue | grep bian`" ];then
	OS=Debian
elif [ ! -z "`cat /etc/issue | grep Ubuntu`" ];then
	OS=Ubuntu
else
	echo "Not support OS, Please reinstall OS and retry!"
	exit 1
fi

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
if [[ ${OS}==CentOS ]];then

	yum install -y python wget unzip tar bc perl git
	yum groupinstall "Development Tools" -y

else

	apt-get update -y
	apt-get install git tar python unzip bc wget unzip perl build-essential -y

	if [[ ${OS}==Ubuntu ]]; then
		apt-get install language-pack-zh-hans -y
	fi

fi


#Clone Something
cd /usr/local
git clone https://github.com/shadowsocksr/shadowsocksr
mv shadowsocksr shadowsocks
git clone https://github.com/FunctionClub/SSR-Bash

#Intall libsodium
cd /root
wget --no-check-certificate -O libsodium-1.0.10.tar.gz https://github.com/jedisct1/libsodium/releases/download/1.0.10/libsodium-1.0.10.tar.gz
tar -xf libsodium-1.0.10.tar.gz && cd libsodium-1.0.10
./configure && make && make install
echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf && ldconfig
cd ../ && rm -rf libsodium* 

#Install ssr-chkconfig
if [[ ${OS}==CentOS ]]; then
	echo "bash /usr/local/SSR-Bash/ssadmin.sh start" >> /etc/rc.d/rc.sysinit
else
	mv /usr/local/SSR-Bash/ssr_chkconfig /etc/init.d/shadowsocksr
	chmod +x /etc/init.d/shadowsocksr
	update-rc.d -f shadowsocksr defaults
fi




#Install Softlink
mv /usr/local/SSR-Bash/ssr /usr/local/bin/
chmod +x /usr/local/bin/ssr

echo '安装完成！输入 ssr 即可使用本程序~'
echo '欢迎加QQ群：277717865 讨论交流哦~'
