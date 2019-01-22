#!/bin/bash
startadb(){
	adb tcpip 5555 2> /dev/null
	#adb shell setprop service.adb.tcp.port 5555 2> /dev/null
	adb connect ${ip}
	adb devices
}

closeadb(){
 for line in `adb devices`
	do
			adb disconnect $line 2> /dev/null
	done
	adb devices
}

findadbs(){
	adb shell ip -f inet addr show wlan0
}

while getopts "p:c h l" arg #选项后面的冒号表示该选项需要参数
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
             h)
						 		echo -e "**注意事项**\n 第一次使用本脚本命令必须用usb连接手机\n"
								echo -e "命令说明:"
                echo -e "1.连接设备:\n\t ${0} -p ip"
								echo -e "2.关闭连接:\n\t ${0} -c"
								echo -e "3.查看[usb/wifi]连接设备ip:\n\t ${0} -l"
                ;;
             ?)  #当有不认识的选项的时候arg为?
            echo "unkonw argument"
        exit 1
        ;;
        esac
done

