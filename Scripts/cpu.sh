#!/system/bin/sh

# Hardcoded paths and values
load=/sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load;
freq=/sys/devices/system/cpu/cpufreq/interactive/hispeed_freq;
freq_original=$(cat $freq);

# Userset values
path=/data/solid/;
if [ -r "$path"thermal ] && [ -r "$path"polling ] ; then
{
	# Reads thermal userset value
	thermal=$(cat "$path"thermal);
	if [ "$thermal" = 0 ]; then
	{
		stop thermal-engine;
	}
	fi

	# Reads CPU polling input boost value
	polling=$(cat "$path"polling);
	for i in $(seq 0 20)
	do
	{
		if [ "$i" = "$polling" ]; then
		{
			polling=$i;
			break;
		}
		fi
	}
	done
}
else
{
	# Create solid directory
	if ! [ -d "$path" ]; then { mkdir $path; } fi
	# Default thermal value
	echo 0 > "$path"thermal;
	stop thermal-engine;
	# Default display values
	size=$(echo $(wm size));
	while [ "$size" != "Physical size: 1440x2560 Override size: 1080x1920" ];
	do
	{
		wm size 1080x1920;
		wm density 480;
		size=$(echo $(wm size));
		sleep 1;
	}
	done
	# Default CPU polling input boost value
	echo 5 > "$path"polling;
	polling=5;
}
fi

if ! [ "$polling" = "0" ]; then
{
while true;
do
{
	getevent -c 1 /dev/input/event1;

	echo 2457600 > $freq;
	echo 0 > $load;

	sleep $polling;

	echo 90 > $load;
	echo "$freq_original" > $freq;
}
done
}
fi
