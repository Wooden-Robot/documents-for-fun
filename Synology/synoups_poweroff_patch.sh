#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
clear
# VAR 	******************************************************************
vAction=$1
# Function List	*******************************************************************************
function install() {
    #备份 /usr/syno/bin/synoups
    cp -n /usr/syno/bin/synoups /usr/syno/bin/synoups.orig
    sed -i 's/\/usr\/syno\/sbin\/synopoweroff -fr/# \/usr\/syno\/sbin\/synopoweroff -fr\n    poweroff/g' /usr/syno/bin/synoups

    echo 'UPS 断电真关机补丁安装成功'
}
function uninstall() {
    #恢复之前备份的 /usr/syno/bin/synoups 文件
    mv -f /usr/syno/bin/synoups.orig /usr/syno/bin/synoups
    echo 'UPS 断电真关机补丁卸载成功'
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

