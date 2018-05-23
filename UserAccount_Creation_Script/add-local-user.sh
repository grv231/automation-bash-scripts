#!/bin/bash

# This script is used for creating a user in linux/unix environments
# Validation is also being done of the user account to check whether the command succeeded
# Finally, displaying the user created along with password and the host on which it was created

# Make sure the script is being executed by superuser privileges
if [[ "${UID}" -ne 0 ]]
then
	echo "The script is not run as root"
	exit 1
fi


# Get the username (login)
read -p "Enter the username: " USER_NAME


# Get the real name and contents for the description
read -p "Enter the real name: " COMMENT


# Get the password
read -p "Enter the password: " PASSWORD


# Create the user with password
useradd -c "${COMMENT}" -m ${USER_NAME}


# Check to see if the useradd command succeeded
if [[ "${?}" -ne 0 ]]
then
    echo "User add command failed"
	exit 1
fi


# Set the password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check to see if password command succeeded
if [[ "${?}" -ne 0 ]]
then
	echo "Password command failed"
	exit 1
fi


# Force password to change on its first login
passwd -e ${USER_NAME}


# Display username, password and host where the user was created
echo
echo 'Username:'
echo "${USER_NAME}"
echo 
echo 'Password:'
echo "${PASSWORD}" 
echo
echo 'Hostname'
echo "${HOSTNAME}"
exit 0
