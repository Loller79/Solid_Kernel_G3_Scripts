#!/system/bin/sh

# Path variable
path=/data/solid/;

# This script will help you configure some basic values for solid kernel
echo "Welcome to the Solid Kernel configuration script";
echo "I'll ask you 4 questions";
echo "";
echo "Do you want the thermal-engine to run or not?"
echo "Type 1 to enable it, 0 to disable it";
echo "Note that solid kernel runs at 1GHz less than normal,";
echo "So there's really not much need for the thermal-engine";
echo "With those conditions, only enable it";
echo "If you're raising your cpu frequency higher";
read -r thermalinput;
if [ -r "$path"thermal ]; then { echo "$thermalinput" > "$path"thermal; } fi
echo "";
echo "What screen resolution would you like to use?";
echo "This kernel uses by default 1080x1920,";
echo "Note that if you type the resolution wrong";
echo "You could soft-brick your device,";
echo "If you don't feel safe type 0 to skip this passage";
read -r resolutioninput;
if [ "$resolutioninput" = "0" ]; then { true; } else {  wm size "$resolutioninput"; } fi
echo "";
echo "What screen density would you like to use?";
echo "The default value is 480, which is perfect for 1080x1920,";
echo "Note that if you type the density wrong";
echo "You could soft-brick your device,";
echo "If you don't feel safe type 0 to skip this passage";
read -r densityinput;
if [ "$densityinput" = "0" ]; then { true; } else { wm density "$densityinput"; } fi
echo "";
echo "How long do you want the CPU input boost to last?";
echo "It lasts by default for 5 seconds,";
echo "Only numbers from 1 to 20 are accepted,";
echo "If you type 0 you'll disable the input boost";
echo "With a great impact on performances";
while true; do { read -r pollinginput; if [ "$pollinginput" -ge 0 ] && [ "$pollinginput" -le 20 ]; then { break; } else { echo "The value you typed isn't correct"; } fi } done
if [ -r "$path"polling ]; then { echo "$pollinginput" > "$path"polling; } fi
echo "Would you like to reboot your device and apply your settings?";
echo "Type 1 if you want to, anything else if not";
read -r rebootinput;
if [ "$rebootinput" = "1" ]; then { reboot; } fi
