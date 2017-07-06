#!/system/bin/sh

# Hardcoded paths and values
governor=/sys/class/devfreq/fdb00000.qcom,kgsl-3d0/governor;
governor_original=performance;
fsync=/sys/module/sync/parameters/fsync_enabled;
check=0;

while true;
do
{
	screen=$(echo $(cat /sys/power/wake_lock));
	if [ "$screen" != "" ]; then
	{
		if [ "$check" = "0" ]; then
		{
			echo "$governor_original" > $governor;
			echo 0 > $fsync;
			check=1;
		}
		fi
	}
	else
	{
		if [ "$check" = "1" ]; then
		{
			governor_original=$(cat $governor);
			echo powersave > $governor;
			echo 1 > $fsync;
			check=0;
		}
		fi
	}
	fi
	sleep 1;
}
done
