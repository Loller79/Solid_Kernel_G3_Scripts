#!/system/bin/sh

# CPU Boost & Solid Kernel Configuration
# Created by Dario Sechi <dario.sechi.7900@gmail.com>

# Hardcoded paths and values
load=/sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load;
freq=/sys/devices/system/cpu/cpufreq/interactive/hispeed_freq;
freq_original=$(cat $freq);

# Userset values
path=/data/solid/;
# Check if files are readable, if they're not then we use default settings
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
	# Check if the polling value is between 0 and 20
	if [ "$polling" -ge 0 ] && [ "$polling" -le 20 ]; then
	{
		polling=$polling;
	}
	else
	{
		# If the user-set value isn't correct set the default one
		polling=3;
	}
	fi
}
else
{
	# Create solid directory
	if ! [ -d "$path" ]; then { mkdir $path; } fi
	# Default thermal value
	echo 0 > "$path"thermal;
	stop thermal-engine;
	# Default display values
	# We use echo to get an inline output
	size=$(echo $(wm size));
	# When this script loads the window manager hasn't started yet,
	# so we loop till it's working and set the FHD variables
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
	echo 3 > "$path"polling;
	polling=3;
}
fi

# Detect if the user has set 0 and thus decided to disable the CPU boost
if [ "$polling" != "0" ]; then
{
while true;
do
{
	# Wait for the user to touch the screen
	getevent -c 1 /dev/input/event1;

	# Use the interactive governor built-in parameter to cheaply boost the CPU freq
	echo 2457600 > $freq;
	echo 0 > $load;

	# Set hold to 1 everytime to avoid nasty problems
	hold=1;
	while [ "$hold" = "1" ]; do
	{
		# Disable hold since the boost started
		echo 0 > "$path"hold;
		# Keep the boost as long as it's set
		sleep $polling;
		# Verify at the end if there have been other touches, if yes boost again
		hold=$(cat "$path"hold);
	}
	done

	# Restore the default values once the work is done
	echo 90 > $load;
	echo $freq_original > $freq;
}
done
}
fi
