# SSR-Bash #
ShadowsocksR多用户管理脚本

## 介绍 ##
一个Shell脚本，集成SSR多用户管理，流量限制，加密更改等基本操作。
如有任何问题和意见，欢迎加QQ群：277717865

为了防止SSR程序被滥用来免流，已经禁止各类非正常Host以及ML有关端口，愿SSR能够继续担当为用户打开通往世界的大门的工具~

## 更新日志 ##
- 修复大量BUG
- 按照破瓦酱的意思，移除了所有的兼容协议
- 脚本一键更新
- 增加备份/还原功能
- 优化用户体验
- 每日凌晨1点钟自动重启服务端
- 每月1号自动清空所有用户已使用流量记录
- 增加批量添加用户功能(实验性的)

## 功能 ##
- 一键开启、关闭SSR服务
- 添加、删除、修改用户端口和密码
- 自由限制用户端口流量使用
- 自动修改防火墙规则
- 自助修改SSR加密方式、协议、混淆等参数
- 自动统计，方便查询每个用户端口的流量使用情况
- 自动安装Libsodium库以支持Chacha20等加密方式
- 更多特性欢迎提议留言

## 缺点 ##
1. 只支持统计IPV4流量
2. 程序路径已写死，只能通过此脚本进行管理

## 系统支持 ##
- Ubuntu 14.04
- Ubuntu 16.10
- Debian7
- Debian8

## 安装 ##
    wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/SSR-Bash/master/install.sh && bash install.sh

## 卸载 ##
    wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/SSR-Bash/master/uninstall.sh && bash uninstall.sh

## 开源许可 ##
本程序大部分代码Fork于[ss-bash](https://github.com/hellofwy/ss-bash)，沿用其[MIT License](https://github.com/hellofwy/ss-bash/blob/master/LICENSE)任何基于本脚本的开发，修改，再发布请不要删除版权声明。请务必遵从以上协议，谢谢~
