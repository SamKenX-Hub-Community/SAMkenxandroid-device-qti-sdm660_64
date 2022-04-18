
p_is_running=0
apk_started=0
# 100ms * 50 = 5s
wait_times=10

is_process_exist()
{
	PROC_NAME=com.mingwork.miditool.factory
	ProcNumber=`ps -ef |grep -w $PROC_NAME|grep -v grep|wc -l`
	if [ $ProcNumber -le 0   ];then
		p_is_running=0
	    #echo "testPro is not run"
		#sh /root/shell/docker-start.sh
	else
		p_is_running=1
		#echo "testPro is  running.."
	fi
}

start_activity()
{
	am start -a net.logitech.midi.factory > /dev/null 2>&1
}

result_ok()
{
	echo "RetVal=PASS"
	echo "Error Message=APK Ready"
	echo "API Status=Sys"
}

result_ng()
{
	echo "RetVal=FAIL"
	echo "Error Message=APK NOT Ready"
	echo "API Status=Sys"
}

result_to()
{
	echo "RetVal=FAIL"
	echo "Error Message=TIMEOUT"
	echo "API Status=Sys"
}

is_apk_started()
{
	let wait_times--
	start_activity
	is_process_exist
	
	if [ $p_is_running -eq 1  ]
	then
		result_ok
		apk_started=1
	else
		#result_ng
		apk_started=0
	fi
	
	if [ $wait_times -eq 0  ]
	then
		result_to
		apk_started=1
	fi
	
}

wait_times=10
status=$(getprop service.bootanim.exit)
[ $status = "1"  ] && while (($apk_started < 1));do is_apk_started;sleep 0.1;done || (result_ng)
