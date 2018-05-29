#!/bin/bash

# This script pings a list of servers from a file and checks whether the servers are up or not

# Variable for storing the server file location
SERVER_FILE="/vagrant/servers"


# Make sure the file is present
if [[ ! -ne "${SERVER_FILE}" ]]
then
	echo "Cannot open the server source file" &> 2
	exit 1
fi


# If the file is present, loop through the entries of the server file
for SERVER in $(cat ${SERVER_FILE})
do
    # Using ping command to send 2 packets for checking connection
    echo "Pinging ${SERVER}"
    ping -c 2 ${SERVER} &> /dev/null
    
    # If the above command ran with a non-zero error status, server would be unreachable
    if [[ "${?}" -ne 0 ]]
    then
        echo "${SERVER} seems to be unreachable"
    
    else
        echo "${SERVER} is up and running"
    fi
done
