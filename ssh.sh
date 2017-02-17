#!/usr/bin/env bash

# Script to remove the default ssh configuration that vagrant creates and to install our own ssh setup!
# Author: Craig Lewis
# Version: 1.0

#Variables
USERNAME="marley"
PASSWORD="marley2017"
#CRYPTPASSWORD=$(echo "$PASSWORD" | openssl enc -aes-128-cbc -a -salt -pass pass:wtf)

#Create a New User

echo "Creating new user: $USERNAME..."

# Check if user already exists.
	
	if [[ -z "$USERNAME" ]] ; then
		
	echo "The user $USERNAME already exists."
 
	else

	echo "The user $USERNAME does not exist and will now be created!"
	useradd -d /home/"$USERNAME" -m -s /bin/bash "$USERNAME"
	echo -e ""$PASSWORD"\n"$PASSWORD"\n" | passwd "$USERNAME" >/dev/null
	echo "The user account is now setup!"

	fi

#Fix for SSH_AUTH_SOCK error in /etc/sudoers.d/
SSH_FIX_FILE="/etc/sudoers.d/root_ssh_agent"
	if [ ! -f  $SSH_FIX_FILE ] ; then
    
    echo "Defaults env_keep += \"SSH_AUTH_SOCK\"" > $SSH_FIX_FILE
    chmod 0440 $SSH_FIX_FILE

	fi




