#upower cat power consumption in watts

upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/energy-rate:/ {printf "%.1f\n", $2}'
exit
