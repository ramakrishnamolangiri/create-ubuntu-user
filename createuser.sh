#!/bin/bash

if whiptail --yesno "Do you want to create user $answer. Are you sure want to continue?" 20 60 ;then

	echo -n "Enter the USERNAME: "
	read USERNAME
	echo -n "Enter the PASSWORD: "
	read -s PASSWORD


	# PASSWORD="krishna123"
	# USERNAME="krishna"

	if id -u "$USERNAME" >/dev/null 2>&1; then
	    userdel -r -f $USERNAME
	    useradd -m -p $PASSWORD -s /bin/bash $USERNAME
	    usermod -a -G sudo $USERNAME
	    echo $USERNAME:$PASSWORD | chpasswd

	else
	    useradd -m -p $PASSWORD -s /bin/bash $USERNAME
	    usermod -a -G sudo $USERNAME
	    echo $USERNAME:$PASSWORD | chpasswd
	fi

	sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

	sudo service ssh restart

else
    echo No
fi


sed -i  "29i $USERNAME ALL=(ALL) NOPASSWD:ALL" /etc/sudoers
sed -i "31i %sudo  ALL=(ALL) NOPASSWD:ALL" /etc/sudoers