# Your own GDB Server paths.
OPENOCD_PATH = /usr/local/bin/openocd
JLINK_PATH = /usr/bin/JLinkGDBServerCLExe

# Board config file for OpenOCD.
CFG_FILE = /home/user/Documents/Projects/study-project-stm-nrf-dac/st_nucleo_l4.cfg

# Device name for JLinkGDBServerCLExe.
DEVICE = STM32L4xxxx

#################################################
# 					actions 					#
#################################################

openocd: kill_openocd
	openocd -s /usr/local/share/openocd/ -f $(CFG_FILE)

kill_openocd:
	-killall -9 openocd

jlink: kill_openocd
	JLinkGDBServerCLExe -if SWD -device $(DEVICE) -port 2331 -singlerun

kill_jlink:
	-killall -9 JLinkGDBServerCLExe


#################################################
# 					 !NOTE! 					#
#	Do not forget to include this file into		#
#	your custom Makefile using the following	#
#	lines:										#
#################################################

#	This part used in a purposes of debugging	#
#		include .vscode/Makefile.gdb.mk			# Uncomment this line
