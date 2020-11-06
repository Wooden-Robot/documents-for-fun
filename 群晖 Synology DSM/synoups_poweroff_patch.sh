#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
clear
# VAR 	******************************************************************
vAction=$1
# Function List	*******************************************************************************
function install() {
    #备份 /usr/syno/bin/synoups
    mv -n /usr/syno/bin/synoups /usr/syno/bin/synoups.orig
    #下载 /usr/syno/bin/synoups 脚本
    wget -O - https://gist.githubusercontent.com/Wooden-Robot/f87814c7d93edd7bee7d1747634546b3/raw/a99bf11290a452d98c11af3de569ea31d960babc/synoups-wrapper >/usr/syno/bin/synoups
    #设置脚本相应权限
    chown root:root /usr/syno/bin/synoups
    chmod 755 /usr/syno/bin/synoups

    echo 'UPS 断电真关机补丁安装成功'
}
function uninstall() {
    #恢复之前备份的 /usr/syno/bin/synoups 文件
    mv -f /usr/syno/bin/synoups.orig /usr/syno/bin/synoups
}

# SHELL 	******************************************************************
if [ "$vAction" == 'install' ]; then
    if [ ! -f "/usr/syno/bin/synoups.orig" ]; then
        install
    else
        echo '你已经添加过 UPS 断电真关机补丁'
        echo '=========================================================================='
        exit 1
    fi
elif [ "$vAction" == 'uninstall' ]; then
    if [ ! -f "/usr/syno/bin/synoups.orig" ]; then
        echo '你还没安装过 UPS 断电真关机补丁'
        echo '=========================================================================='
        exit 1
    else
        uninstall
    fi
else
    echo '错误的命令'
    echo '=========================================================================='
    exit 1
fi

