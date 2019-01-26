# xadb工具说明书

## 目标

WiFi环境下,放弃usb线条,远程调试

## 使用步骤

1. 下载 adbutils.sh, 赋予执行权限 chmod +x adbutils.sh
1. 安装xadb
	1.  adbutils -i
1. 找到手机ip,连接设备 xadb -p ip
1. 其他
	1. xadb -h 帮助
	1. xadb -c 断开所有远程设备

## 错误处理

### /usr/local/bin/xadb: line 18: adb: command not found
解决方案:
  1. 安装Homebrew
    1. https://brew.sh/
  2. ​brew cask install android-platform-tools​
  3. ​adb devices​ 有正确输出即可.

### xadb -p xx.xx.xx.xx:出现confuse xxx, 
多试几次命令,手机的调试服务还在启动
第一次使用本脚本命令必须用usb连接手机,以启动远程服务
