
wait_times=30
is_timeout=0
is_done=0

status="ng"
my_name=""
param1=$1


decode_name()
{
	str=$(basename $0)
	my_name=${str%.*}
}

error_msg_apk_not_ready()
{
	echo "RetVal=FAIL"
	echo "Error Message=APK NOT READY"
	echo "API Status=SYS"
}

error_msg_to()
{
	echo "RetVal=FAIL"
	echo "Error Message=TIMEOUT"
	echo "API Status=SYS"
}

return_result()
{
	getprop $my_name.return.value
	getprop $my_name.error.msg
	getprop $my_name.api.status
}

cmd_process()
{
	status=$(getprop $my_name.status)
	if [ $status == "ok"  ]
	then
		return_result
		is_done=1
	elif [ $status == "ng" ]
	then
		error_msg_apk_not_ready
		is_done=1
	elif [ $status == "ready" ]
	then
		sleep 1
	else		# Unkonwn status
		sleep 1
	fi
}

main_process()
{
	let wait_times--
	cmd_process
	
	if [ $wait_times -eq 0  ]
	then
		is_timeout=1
		error_msg_to
	fi
	
}

prop_init()
{
	setprop $my_name.status ng
}

send_broadcast()
{
	am broadcast -a $my_name --es flag $param1 > /dev/null
}


# 0. fetech the name
decode_name

# 1. first init prop
prop_init

# 2. send broadcast
send_broadcast


is_timeout=0
while (($is_timeout == 0 && $is_done == 0))
do
	main_process
done








