#!/bin/bash
# systemHealth.bash
# Purpose: Generate a quick system health report (uptime, CPU load, memory,disk usage, and top resource-consuming processes) and log it to a report file in the home directory
#
# Usage: ./systemHealth.bash
#
# Author: Avraham (Avi) Abel
# Date: July/30/2026

# Welcome splash screen
echo "System Health Report"
printf '#%.0s' {1..35}
printf "\n"

# Checking user if they are in sudo/root or not
user=$(whoami)
if [ "$user" != "root" ] # only runs if using sudo or root
then
 echo "Error! You must run this script with root privileges. Please use sudo!" >&2
 exit 1
fi

# Set color variables for section headers
BOLD='\033[1m'
RESET='\033[0m'

# Set path for the report log file
report_file="/home/aabel/bash-scripts/logs/systemReports"

# Function: print_section
# Prints a bolded subsection label
# $1 = section label
print_section () {
 label=$1
 echo -e "${BOLD}${label}${RESET}"
}

# Everything below is piped through tee so it prints to screen AND appends to the report file
{
# Basic system info
echo "Generated on: $(date)"
echo "Host Name   : $(hostname)"
echo "Kernel      : $(uname -r)"
echo "Uptime      : $(uptime -p)"
echo "--------------------------------------"

# CPU load average
print_section "CPU Load Average:"
uptime | awk -F'load average:' '{ print $2 }'
echo "--------------------------------------"

# Memory usage
print_section "Memory Usage:"
free -h | awk 'NR==1{print $0} NR==2{print $0}'
echo "--------------------------------------"

# Disk usage
print_section "Disk Usage (/):"
df -h / | awk 'NR==1{print $0} NR==2{print $0}'
echo "--------------------------------------"

# Top 5 CPU-consuming processes
print_section "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo "--------------------------------------"

# Top 5 memory-consuming processes
print_section "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo "--------------------------------------"

# Logged-in users
print_section "Logged-in Users:"
who
echo "======================================"
} | tee -a "$report_file"

echo "Report saved to: ${report_file}"
