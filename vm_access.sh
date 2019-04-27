#!/bin/bash

#-------------------------------------------------------------
# 変数
#------------------------------------------------------------
TEST_CONN=`ssh multione date | awk '{print $5}'`
FND_VNCN=`ssh multione "ls -l /tmp/.X11-unix/X?" | awk '{print $9}' | cut -c 17`
#DLT_SKT=`ssh multione "find /tmp/.X11-unix/ -type s -not -name 'X0' -delete"`
BLU_FNT='\033[0;34m'
RD_FNT='\033[1;31m'
NC='\033[m'

#-------------------------------------------------------------
# Funtions
#-------------------------------------------------------------
menu_access(){
echo "  +=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+
  | Chose your connection type !                  |
  +-----------------------------------------------+
  |   [0] SSH                                     |
  |   [1] VNC                                     |
  |   [2] CANCEL                                  |
  |                                               |
  +=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=+
    "
}

ssh_access(){
	echo -n "ssh access starting"
	for run in {1..3}; do sleep 0.5 && echo -n "."; done
	ssh allen@multione
	exit
}

vnc_access(){
	for SRCHR in $FND_VNCN ; do
		if [ "$SRCHR" -gt "0" ]; then 
		ssh multione find /tmp/.X11-unix/ -type s -not -name 'X0' -delete
		ssh multione vncserver -kill :$SRCHR
		fi
	done
	echo -n "VNC Conneting"
	for run in {1..3}; do sleep 0.5 && echo -n "."; done
	ssh multione vncserver :1 -geometry 1280x800 -depth 24
	krdc vnc://allen@multione:1 &
}


#-------------------------------------------------------------
# Testing connection
#-------------------------------------------------------------
if [ "$TEST_CONN" = "UTC" ]; then
	printf "${BLU_FNT}CONNECTION AVAILABLE ! ${NC}\n"
else
	printf "${RD_FNT}Unvailable to connect now!
Check the username or interface status, then try again later!${NC}\n"
fi


#-------------------------------------------------------------
# Process Connections
#-------------------------------------------------------------
menu_access
echo -n "Chose one type connection: "
read CONNTYP
case $CONNTYP in
 0)
   ssh_access
   exit
   ;;

 1)
   vnc_access
   exit
   ;;

 2)
   echo -n "Canceling Access"
   for run in {1..3}; do sleep 0.5 && echo -n "."; done && echo
   exit
   ;;

 *)
   read -p "Chose [0 | 1 | 2],then try again!"
   exit
   ;;
esac

