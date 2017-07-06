#Description
These scripts are used in the Solid_Kernel_G3_NOUGAT project, they do in a simple way what I still have to implement in the kernel source code.

#Details
Both scripts are optimized for CPU usage even if they use while loops, battery shouldn't be affected in the long run since the CPU load is lower than 1%.

#CPU Script Description
Its main focus is to boost the CPU as soon as the screen is touched, other non-related things have been added to avoid creating another script, these other things handle the user-defined variables regarding the thermal control and the CPU boost polling, with an extra compononet that sets the screen resolution to FHD only the first time the kernel boots, then the user is free to change it whenever he wants with the configuration script.

#GPU Script Description
Its called GPU though its main focus is to detect when the screen is on or off, when it's on the GPU governor is set to the one the user is using at the moment, the fsync gets disabled to guarantee better I/O performances while the user is using the device, as soon as the screen is off the governor is set to powersave to optimize the consumption especially when using GPU performance governor, the fsync is finally enabled to avoid the possible risk of losing/corrupting data.

#Configuration Script Description
It helps the user configure some parameters used by both kernel and scripts, alongside with resolution and dpi control. Its job is to allow even non-expert users to understand what they're doing and easily configuring vital variables of the device like CPU boost duration, thermal control and resolution/dpi management.
