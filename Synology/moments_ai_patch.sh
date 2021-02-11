#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
clear
# VAR 	******************************************************************
vAction=$1

function generate_moments_detection() {
    wget -O - https://raw.githubusercontent.com/Wooden-Robot/documents-for-fun/master/Synology/libsynophoto-plugin-detection.so  >/var/packages/SynologyMoments/target/usr/lib/libsynophoto-plugin-detection.so

}

# Function List	*******************************************************************************
function install() {
    #备份 moments detection
    mv /var/packages/SynologyMoments/target/usr/lib/libsynophoto-plugin-detection.so /var/packages/SynologyMoments/target/usr/lib/libsynophoto-plugin-detection.so.bak
    # 生成 detection 脚本
    generate_moments_detection

    echo '请重新启动Moments，并测试人脸识别是否正常工作'
}
function uninstall() {
    #恢复之前备份的 moments libsynophoto-plugin-detection.so文件
    mv -f /var/packages/SynologyMoments/target/usr/lib/libsynophoto-plugin-detection.so.bak /var/packages/SynologyMoments/target/usr/lib/libsynophoto-plugin-detection.so
    }

# SHELL 	******************************************************************
if [ "$vAction" == 'install' ]; then
    if [ ! -f "/var/packages/SynologyMoments/target/usr/lib/libsynophoto-plugin-detection.so.bak" ]; then
        install
        echo '成功安装人脸识别支持补丁'
    else
        echo '你已经添加过人脸识别支持补丁'
        echo '=========================================================================='
        exit 1
    fi
elif [ "$vAction" == 'uninstall' ]; then
    if [ ! -f "/var/packages/SynologyMoments/target/usr/lib/libsynophoto-plugin-detection.so.bak" ]; then
        echo '你还没安装过人脸识别支持补丁'
        echo '=========================================================================='
        exit 1
    else
        uninstall
        echo '成功卸载人脸支持补丁'
    fi
else
    echo '错误的命令'
    echo '=========================================================================='
    exit 1
fi

