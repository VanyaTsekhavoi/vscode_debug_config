#*************************************************************************#
#                                                                         #
#   Connect to the OpenOCD gdb server (opyional flash of an executable).  #
#   See:    https://openocd.org/doc/html/GDB-and-OpenOCD.html             #
#                                                                         #
#*************************************************************************#

target extended-remote localhost:3333
monitor reset halt
set arch arm
set _CHIPNAME <f.e. stm32l4x>
set _ELF <path to executable>

#*************************************************************************#
#   .ELF FILE IS ALREADY UPLOADED INTO THE GDB CLIENT VIA COMMAND LINE    #
#   ARGS (BUT TO BE SURE OR STANDALONE USAGE).                            #
#       Usage:  load <filename> <offset>                                  #
#           or: load                                                      #
#*************************************************************************#

file $_ELF
load

monitor $_CHIPNAME.cpu configure -event gdb-detach { shutdown }
break main

# Disables confirmation requests.
set confirm off
monitor reset halt
continue