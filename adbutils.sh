#!/bin/bash
startadb(){
	adb tcpip 5555 2> /dev/null
	#adb shell setprop service.adb.tcp.port 5555 2> /dev/null
	adb connect ${ip}
}

closeadb(){
 for line in `adb devices | awk '{print $1}' | sed -n '2,$p'`
	do
		if [ -n "$line" ]; then 
			adb disconnect $line
		fi
	done
}

findadbs(){
	echo "List of devices ips"
	for line in `adb devices | awk '{print $1}' | sed -n '2,$p'`
	do
		if [ -n "$line" ]; then 
			thisIp=`adb -s $line shell ip -f inet addr show wlan0 | grep inet | awk '{print $2}'`
			echo -e "$line\t${thisIp}"
		fi
	done
}

install(){
	SHELL_FILE=$(cd "$(dirname "$0")";pwd)/${0}
	cp -r ${SHELL_FILE} /usr/local/bin/xadb
}

listDevices(){
	adb devices
}

while getopts "p:c h l i d" arg
do
        case $arg in
             p)
								ip=$OPTARG
								startadb
                ;;
             c)
                closeadb
                ;;
						 l)
						 		findadbs
						 		;;
						 i)
								install
						 		;;
						 d)
								listDevices
						 		;;
             h)
								echo -e "\n命令说明:"
								echo -e "1.安装xadb:\n\t ${0} -i\n"
                echo -e "2.连接设备:\n\t ${0} -p ip\n"
								echo -e "3.关闭连接:\n\t ${0} -c\n"
								echo -e "4.查看[usb/wifi]连接设备ip:\n\t ${0} -l\n"
								echo -e "5.查看[usb/wifi]连接设备:\n\t ${0} -d\n"
								echo -e "6.帮助:\n\t ${0} -h\n"
						 		echo -e "**注意事项**\n\t 第一次使用本脚本命令必须用usb连接手机\n"
								echo -e "如有其他帮助,请联系作者:\n\t zhangchong.ff@bytedance.com"
                ;;
             ?) 
            echo "unkonw argument"
        exit 1
        ;;
        esac
done

