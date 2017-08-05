#!/system/bin/sh

# GPU Control Through Screen ON/OFF
# Created by Dario Sechi <dario.sechi.7900@gmail.com>

# Hardcoded paths and values
governor=/sys/class/devfreq/fdb00000.qcom,kgsl-3d0/governor;
governor_original=performance;
check=0;

while true;
do
{
	# This file only gives output if the screen is on
	screen=$(echo $(cat /sys/power/wake_lock));
	if [ "$screen" != "" ]; then
	{
		# The output is empty if the device is sleeping, however sometimes this isn't true
		if [ "$screen" != "PowerManagerService.WakeLocks" ]; then
		{
			# We use the check variable to let the code run only once and avoid
			# useless rewrites that could deteriorate performances
			if [ "$check" = "0" ]; then
			{
				echo $governor_original > $governor;
				check=1;
			}
			fi
		}
		else
		{
			if [ "$check" = "1" ]; then
			{
				# Save the governor that the user is using before forcing powersave
				governor_original=$(cat $governor);
				echo powersave > $governor;
				check=0;
			}
			fi
		}
		fi
	}
	else
	{
		if [ "$check" = "1" ]; then
		{
			# Save the governor that the user is using before forcing powersave
			governor_original=$(cat $governor);
			echo powersave > $governor;
			check=0;
		}
		fi
	}
	fi
	# Sleep 1 second to avoid high CPU usage
	sleep 1;
}
done
