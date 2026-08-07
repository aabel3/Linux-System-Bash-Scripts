#!/bin/bash
# pingtest.bash
# Purpose: Script to test ping to all the hosts on the local network
#
# Usage: ./pingTest.bash
#
# Author: Avraham Abel
# Date: July/28/2026


# Welcom splash screen
echo "Linux host and Virtual Machine ping test"
printf '#%.0s' {1..40}
printf "\n"

# Checking user if they are in sudo/root or not
user=$(whoami)
if [ $user != "root" ] # only runs if using sudo or root
then
 echo "Error! You must run this script with root privileges. Please use sudo!" >&2
 exit 1
fi

# Read /etc/hosts one line at a time
while read line
do
    # Check if the line starts with an IPv4 address (e.g. 192.168.245.10)
    # Regex breakdown: ([0-9]{1,3}\.){3}[0-9]{1,3} matches four number groups separated by dots
    if echo $line | grep -E "^([0-9]{1,3}\.){3}[0-9]{1,3}" >> /dev/null
    then
        # Extract the first column (IP address) from the line
        addr=$(echo $line | cut -f1 -d' ')

        # Extract the second column (hostname) from the line
        host=$(echo $line | cut -f2 -d' ')

        # Send a single ping (-c1) to the address, suppress output
        if ping -c1 $addr > /dev/null
        then
            # Ping succeeded — host is reachable
            echo "✅ $host: online!"
        else
            # Ping failed — host is unreachable
            echo "🚨 $host: offline..."
        fi
    fi
done < /etc/hosts   # Feed /etc/hosts into the while loop line by line
