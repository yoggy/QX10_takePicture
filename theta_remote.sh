#!/bin/sh
# --------------------------------
#   THETA Remote for PQI Air Pen
# --------------------------------
# http://mobilehackerz.jp/ mobilehackerz@gmail.com

ssid=$1
pass=$2

theta_ip=192.168.1.1
theta_port=15740
trigger_port=5211
trigger_gpio=/proc/gpio/gpio22_in

echo 1 > /proc/gpio/gpio23_out
/tmp/www/ftp/sda1/theta/sleepms 100
echo 0 > /proc/gpio/gpio23_out
sleep 1
echo 1 > /proc/gpio/gpio23_out
/tmp/www/ftp/sda1/theta/sleepms 100
echo 0 > /proc/gpio/gpio23_out
sleep 1
echo 1 > /proc/gpio/gpio23_out
/tmp/www/ftp/sda1/theta/sleepms 100
echo 0 > /proc/gpio/gpio23_out

wget="/tmp/www/ftp/sda1/theta/busybox-mips wget -O -"
awk="/tmp/www/ftp/sda1/theta/busybox-mips awk"
prefix="http://127.0.0.1/cgi-bin/cmd"
status=""

while [ 1 ]
do
	sleep 1
	echo Scanning..
	iwlist ath0 scan2file > /tmp/www/aplist.xml
	channel=`$awk -v essid="${ssid}" '\
BEGIN { found=0; } \
/<ESSID>(.*?)<\/ESSID>/ { gsub(/<[^>]*>/,""); gsub(/[ \t]/,""); if ($0 == essid) { found=1; } else { found=0; } } \
/<Channel>(.*?)<\/Channel>/ { gsub(/<[^>]*>/,""); gsub(/[ \t]/,""); if (found == 1) { print $0; } } \
' /tmp/www/aplist.xml`
	if test ${channel} -ne 0
	then
		break
	fi
done
echo Channel ${channel}

cfg -a STA_SSID=${ssid}
cfg -a STA_SECMODE=WPA-PSK
cfg -a STA_PASSWD=${pass}
$wget "${prefix}%3fcmd%3dCONNECT"
cfg -a AP_PRIMARY_CH=${channel} && iwconfig ath0 channel ${channel}


while [ 1 ]
do
	sleep 1
	read status < /tmp/staState
	echo Status ${status}
	if test ${status} = "Connected"
	then
		break
	fi
done

killall "rc"

while [ 1 ]
do
	# Wait for press button
	trig=1
	while [ $trig -eq 1 ]
	do
		/tmp/www/ftp/sda1/theta/sleepms 50
		read trig < $trigger_gpio
	done
	
	# Shutter
	/tmp/www/ftp/sda1/theta/QX10_takePicture 10.0.0.1 10000

	# Wait for release button
	while [ $trig -eq 0 ]
	do
		/tmp/www/ftp/sda1/theta/sleepms 50
		read trig < $trigger_gpio
	done
done
