# cat uptime 

awk '{printf "%dH:%02dM\n", int($1/3600), int(($1%3600)/60)}' /proc/uptime
exit
