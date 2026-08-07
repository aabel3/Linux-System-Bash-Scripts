#!/bin/bash
# backupVM.bash
# Purpose: Backup VM images
#
# Usage: ./backupVM.bash
#
# Author: Avraham (Avi) Abel
# Date: July/27/2026

# Welcome splash screen
echo "KVM/Libvirt virtual machine backups"
printf '#%.0s' {1..35}
printf "\n"

# Checking user if they are in sudo/root or not
user=$(whoami)
if [ "$user" != "root" ] # only runs if using sudo or root
then
 echo "Error! You must run this script with root privileges. Please use sudo!" >&2
 exit 1
fi

# Set variables for source path and backup path
img_path="/var/lib/libvirt/images/"
backup_path="/home/aabel/VirtualMachine-Backups/"

# Function: progress_bar
# Prints "#" characters at regular intervals while a background PID is running
# $1 = PID of the background process to watch
# $2 = label to show next to the bar
progress_bar () {
 pid=$1
 label=$2
 printf "%s [" "$label"
 while kill -0 "$pid" 2>/dev/null
 do
  printf "#"
  sleep 0.5
 done
 printf "] done\n"
}

# Function: backup_vm
# Runs gzip on one VM image in the background and shows the progress bar
# $1 = vm name (without .qcow2 extension)
backup_vm () {
 vm=$1
 echo "Backing up VM: ${vm}"
 gzip < "${img_path}${vm}.qcow2" > "${backup_path}${vm}.qcow2.gz" &
 gzip_pid=$!
 progress_bar "$gzip_pid" "${vm}"
 wait "$gzip_pid"
 echo "${vm}: Backup successfully completed!"
}

# Build list of available VMs from the images directory (any name, *.qcow2)
mapfile -t available_vms < <(cd "${img_path}" && ls *.qcow2 2>/dev/null | sed 's/\.qcow2$//')

if [ ${#available_vms[@]} -eq 0 ]
then
 echo "No VM images found in: ${img_path}" >&2
 exit 3
fi

# Ask individually for each VM found in img_path
for vm in "${available_vms[@]}"
do
 read -p "Would you like to backup VM ${vm}? (y/n): " vmanswer

 until [ "$vmanswer" = "y" ] || [ "$vmanswer" = "n" ]
 do
  read -p "Invalid Selection. Backup VM: ${vm}? (y/n): " vmanswer
 done

 # User inputs y = backup is being run
 # User inputs n = backup is not run and overly done
 if [ "$vmanswer" = "y" ]
 then
  backup_vm "$vm"
 else
  echo "Skipping over VM ${vm}"
 fi
done
