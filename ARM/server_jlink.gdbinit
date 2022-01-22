#************************************************************************************#
#                                                                         	         #
#   Connect to the J-Link gdb server (opyional flash of an executable). See:	     #
#   https://www.micro-semiconductor.nz/datasheet/d1-8.08.28-J-LINK-PLUS.pdf (p368)   #
#                                                                         	         #
#************************************************************************************#

target extended-remote localhost:2331
monitor speed adaptive
monitor reset 0
set arch arm
set _CHIPNAME <f.e. STM32L4>
set _ELF <path to executable>

#*************************************************************************#
#   .ELF FILE IS ALREADY UPLOADED INTO THE GDB CLIENT VIA COMMAND LINE    #
#   ARGS (BUT TO BE SURE OR STANDALONE USAGE).                            #
#       Usage:  load <filename> <offset>                                  #
#           or: load                                                      #
#*************************************************************************#

monitor flash device = $_CHIPNAME
monitor flash download=1
file $_ELF
load

monitor $_CHIPNAME.cpu configure -event gdb-detach { shutdown }
break main

# Disables confirmation requests.
set confirm off
monitor reset 0
continue