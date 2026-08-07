# diskMonitor.bash

A simple Bash script that checks root partition (`/`) disk usage on Linux, renders it as an ASCII bar chart, and warns you if usage crosses a critical threshold.

## Features

- **Live usage check** — pulls current root partition usage from `df` every time it runs, so results always reflect the current state of the system.
- **ASCII bar chart** — renders a 40-character-wide progress bar so usage is easy to read at a glance.
- **Configurable threshold** — compares usage against a threshold (default `85%`) that you can change in one place.
- **Clear status output** — prints a ✅ healthy message when usage is below threshold, or a 🚨 warning when it's at or above it.
- **Root privilege check** — exits with an error if not run as root/sudo.

## Requirements

- Linux system with a standard root (`/`) partition
- Bash
- `df`, `awk`, `sed` (installed by default on most distros)
- Root privileges (or `sudo`)

## Installation

This script lives in the `diskMonitor/` folder of the [Linux-System-Bash-Scripts](https://github.com/aabel3/Linux-System-Bash-Scripts) repository. Clone the repo and make the script executable:

```bash
git clone https://github.com/aabel3/Linux-System-Bash-Scripts.git
cd Linux-System-Bash-Scripts/diskMonitor
chmod +x diskMonitor.bash
```

## Configuration

The alert threshold is set as a variable near the top of the script — open `diskMonitor.bash` and edit it if you want a different alert level:

```bash
THRESHOLD=85
```

- `THRESHOLD` — the usage percentage (0–100) that triggers a warning. Default is `85`.

## Usage

Run the script with root privileges:

```bash
sudo ./diskMonitor.bash
```

You will see a welcome banner, followed by the usage bar and a status message:

```
Linux Disk Space Monitor
########################

Disk usage for aabel@laptop: 
[###############################-------] 78%

✅ CONGRADUATIONS: Your system healthy. Disk usage is at: 78%.
```

If usage is at or above the threshold, the status message switches to a warning instead:

```
🚨 WARNING: Root partition space is critically low!
Current usage is at: 91% (Threshold: 85%).
```

## How It Works

1. Checks that the script is being run as root; exits if not.
2. Reads current root partition usage percentage using `df / ` piped through `awk` and `sed`.
3. Draws a 40-character ASCII bar scaled to the usage percentage.
4. Compares usage against `THRESHOLD` and prints either a warning or a healthy status message.

## Author

Avraham (Avi) Abel — July 27, 2026
