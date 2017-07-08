#!/system/bin/sh

# CPU Boost Pt.2
# Created by Dario Sechi <dario.sechi.7900@gmail.com>

# Userset values
path=/data/solid/;
if [ -r "$path"polling ]; then
{
	polling=$(cat "$path"polling);
}
else
{
	polling=5;
}
fi

# Detect if the user has set 0 and thus decided to disable the CPU boost
if [ "$polling" != "0" ]; then
{
while true;
do
{
	# If the screen is touched again signal to keep boosting
	getevent -c 1 /dev/input/event1;
	
	# Write on a file that the boost must be repeated
	echo 1 > "$path"hold;
}
done
}
fi