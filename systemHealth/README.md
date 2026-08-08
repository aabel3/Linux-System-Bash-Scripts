# systemHealth.bash

A simple Bash script that generates a quick system health report on Linux — uptime, CPU load, memory, disk usage, and top resource-consuming processes — printing it to the screen while also appending it to a log file.

## Features

- **Full snapshot in one run** — host name, kernel version, uptime, CPU load, memory, disk usage, top 5 CPU processes, top 5 memory processes, and logged-in users.
- **Screen + log output** — prints the report to the terminal and appends it to a log file at the same time using `tee -a`, so nothing is lost between runs.
- **Running history** — each run appends a new timestamped entry rather than overwriting the last one, building a history of past reports over time.
- **Readable formatting** — section headers print in bold using ANSI escape codes for easy scanning in the terminal.
- **Root privilege check** — exits with an error if not run as root/sudo.

## Requirements

- Linux system
- Bash
- Standard coreutils/procps tools: `uptime`, `free`, `df`, `ps`, `who`, `hostname`, `uname` (installed by default on most distros)
- Root privileges (or `sudo`)

## Installation

This script lives in the `systemHealth/` folder of the [Linux-System-Bash-Scripts](https://github.com/aabel3/Linux-System-Bash-Scripts) repository. Clone the repo and make the script executable:

```bash
git clone https://github.com/aabel3/Linux-System-Bash-Scripts.git
cd Linux-System-Bash-Scripts/systemHealth
chmod +x systemHealth.bash
```

## Configuration

The report log path is set as a variable near the top of the script — open `systemHealth.bash` and edit it if your environment is different:

```bash
report_file="/home/aabel/bash-scripts/logs/systemReports"
```

- `report_file` — where the report is appended each run. The parent directory must exist before running, or the report cannot be saved:

```bash
mkdir -p /home/aabel/bash-scripts/logs
```

## Usage

Run the script with root privileges:

```bash
sudo ./systemHealth.bash
```

You will see a welcome banner, followed by the full health report:

```
System Health Report
###################################
Generated on: Thu Jul 30 14:02:11 EDT 2026
Host Name   : laptop
Kernel      : 6.8.0-generic
Uptime      : up 3 hours, 12 minutes
--------------------------------------
CPU Load Average:
 0.42, 0.38, 0.35
--------------------------------------
Memory Usage:
              total        used        free
Mem:           15Gi       4.2Gi       9.1Gi
--------------------------------------
Disk Usage (/):
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   14G   34G  30% /
--------------------------------------
Top 5 Processes by CPU Usage:
    PID COMMAND         %CPU
   1842 gnome-shell      4.2
--------------------------------------
Top 5 Processes by Memory Usage:
    PID COMMAND         %MEM
   1842 gnome-shell      3.1
--------------------------------------
Logged-in Users:
aabel    tty2         2026-07-30 11:00
======================================
Report saved to: /home/aabel/bash-scripts/logs/systemReports
```

## How It Works

1. Checks that the script is being run as root; exits if not.
2. Collects basic system info: hostname, kernel version, and uptime.
3. Pulls CPU load average, memory usage, and root partition disk usage from `uptime`, `free`, and `df`.
4. Lists the top 5 processes by CPU usage and the top 5 by memory usage using `ps`.
5. Lists currently logged-in users with `who`.
6. Pipes the entire report through `tee -a` so it prints to the screen and appends to the log file in the same step.

## Notes

- Because output is appended rather than overwritten, the log file grows over time — consider rotating or clearing it periodically.

## Author

Avraham (Avi) Abel — July 30, 2026
