setprop net.logitech.midi.serial.no.status ng;am broadcast -a net.logitech.midi.serial.no > /dev/null;timeout=38;while ((timeout > 0));do let timeout--;status=$(getprop net.logitech.midi.serial.no.status);[ $status = "ok" ] && getprop net.logitech.midi.serial.no.return.value && getprop net.logitech.midi.serial.no.error.msg && getprop net.logitech.midi.serial.no.api.status  && break || sleep 0.8 && [ $status = "ng" ] && echo "RetVal=None" && echo "Error Message=APK NOT Ready" && echo "API Status=Sys" && break;done ;if [ $timeout -eq 0  ];then echo "RetVal=None";echo "Error Message=Timeout";echo "API Status=Sys";else echo "";fi