setprop net.logitech.midi.mute.close.status ng;am broadcast -a net.logitech.midi.mute.close > /dev/null;timeout=38;while ((timeout > 0));do let timeout--;status=$(getprop net.logitech.midi.mute.close.status);[ $status = "ok" ] && getprop net.logitech.midi.mute.close.return.value && getprop net.logitech.midi.mute.close.error.msg && getprop net.logitech.midi.mute.close.api.status  && break || sleep 0.8 && [ $status = "ng" ] && echo "RetVal=None" && echo "Error Message=APK NOT Ready" && echo "API Status=Sys" && break;done ;if [ $timeout -eq 0  ];then echo "RetVal=None";echo "Error Message=Timeout";echo "API Status=Sys";else echo "";fi