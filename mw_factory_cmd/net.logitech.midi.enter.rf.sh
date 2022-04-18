killall ftmdaemon > /dev/null 2>&1
svc wifi disable > /dev/null 2>&1
lsmod > /dev/null 2>&1
rmmod wlan > /dev/null 2>&1
insmod /vendor/lib/modules/qca_cld3_wlan.ko > /dev/null 2>&1
ifconfig wlan0 up > /dev/null 2>&1
echo 5 > /sys/module/wlan/parameters/con_mode 
ftmdaemon -n -dd > /dev/null 2>&1 &

echo "RetVal=PASS" 
echo "Error Message=None"
echo "API Status=Ack"
