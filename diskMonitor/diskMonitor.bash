#!/bin/bash
# diskMonitor.bash
# Purpose: Monitor root partition disk space and alert if usage is critically high
#
# Usage: sudo ./diskMonitor.bash
#
# Author: Avraham (Avi) Abel
# Date: July/27/2026

# Welcome splash screen
echo "Linux Disk Space Monitor"
printf '#%.0s' {1..24}
printf "\n"

# Checking if user is running as root/sudo
user=$(whoami)
if [ "$user" != "root" ]  # only runs if using sudo or root
then
    echo "Error! You must run this script with root privileges. Please use sudo!"
    exit 1
fi

# Checking threshold of the computer
THRESHOLD=85
CURRENT_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

# Draws a simple ASCII bar chart of disk usage
draw_bar() {
    local percent=$1
    local width=40
    local filled=$(( percent * width / 100 ))
    local empty=$(( width - filled ))
    printf "["
    printf '#%.0s' $(seq 1 $filled) 2>/dev/null
    printf '%.0s-' $(seq 1 $empty) 2>/dev/null
    printf "] %s%%\n" "$percent"
}

echo ""
echo "Disk usage for aabel@laptop: "
draw_bar "$CURRENT_USAGE"
echo ""

# If threshold is exceeded, then warn the user
if [ "$CURRENT_USAGE" -ge "$THRESHOLD" ]; then
    echo "🚨 WARNING: Root partition space is critically low!"
    echo "Current usage is at: ${CURRENT_USAGE}% (Threshold: ${THRESHOLD}%)."

# If threshold is not exceeded, then all systems are go
else
    echo "✅ CONGRADUATIONS: Your system healthy. Disk usage is at: ${CURRENT_USAGE}%."
fi
