#!/bin/bash

# var - start

# version
VERSION='1.0'

# text color and formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1;37m'
ITALICS='\033[4;37m'
OFF='\033[0m'

# current user
IAM=$(id -u)

# today
STARTED=`date "+%Y-%m-%d %T %Z"`

# log location
LOGS='/var/log/honeyport.log'

# var - stop

# func - start

# Man Page "Help Menu"
manPage(){
    echo -e "${BOLD}NAME:${OFF}"
    echo -e "\tHoneyPorts\n"
    echo -e "${BOLD}DESCRIPTION:${OFF}"
    echo -e "\tHoneyPorts - a script to monitory ports for potential scanning/enumeration/or other hacking on the system\n"
    echo -e "${BOLD}VERSION:${OFF}"
    echo -e "\tv$VERSION\n"
    echo -e "${BOLD}SYNOPSIS:${OFF}"
    echo -e "\thoneyport.sh [${ITALICS}OPTION${OFF}]\n"
    echo -e "${BOLD}FLAGS:${OFF}"
    echo -e "\t${BOLD}--port, -p${OFF}                 specific port to use as honeyport"
    echo -e "\t${BOLD}--help, -h${OFF}                 show help"
    echo -e "\t${BOLD}--version, -v${OFF}              output version info\n"
    echo -e "${BOLD}EXAMPLES:${OFF}"
    echo -e "\tsudo honeyport.sh -p 2340\n"
    echo -e "${BOLD}AUTHOR:${OFF}"
    echo -e "\tWritten by Gabriel Simches\n"
    echo -e "${BOLD}COPYRIGHT${OFF}"
    echo -e "\tThis is free software\n"
    return $1
}

versionCheck(){
    echo "Honeyport version $VERSION"
}

# func - stop

# script - start
clear

# if check for any required arguments or required user

if [ $IAM -gt 0 ]
then
    echo -e "${RED}You must use sudo to run this script.${OFF}"
    exit 1
fi

case $1 in
    -p | --port)
        echo -e "[-]${BOLD} Honeyports activated...${OFF}"
        echo "[-] $STARTED"
	      echo -e "[*] Log file located at: $LOGS\n"
        # save start time to log file
        while [ 1 ] 
        do
            IP=`nc -nvlp $2 2>&1 1> /dev/null | grep from | awk '{print $4}' |grep -E "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | grep : | cut -d ':' -f 1` 
	    TIMEDETECTED=`date "+%Y-%m-%d %T %Z"`
	    iptables -A INPUT -p tcp -s $IP -j DROP
            echo -e "${GREEN}[+]${OFF} ${YELLOW}$IP${OFF} has been ${RED}blocked${OFF}!"
            # grab timestamp, source IP, log to file
	    echo -e "$TIMEDETECTED\t\t$IP\tBlocked when attempting to connect to honeyport $2" >> $LOGS
        done
    ;;
    -h | --help)
        manPage 0 # exit sucessfully
    ;;
        -v | --version)
        versionCheck
    ;;
    *)
        echo -e "\nCommand flags are required for this script.  Review Man Page below:\n"
        manPage 1 # exit error
esac

# script - stop
