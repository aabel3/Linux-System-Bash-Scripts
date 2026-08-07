# Linux-System-Bash-Scripts

A growing collection of BASH scripts for Linux system administration and maintenance, written and maintained by Avraham (Avi) Abel. Each script lives in its own folder alongside a dedicated README explaining its purpose and usage.

## Repository Layout

```
Linux-System-Bash-Scripts/
├── README.md
├── backupVM/
│   ├── backupVM.bash
│   └── README.md
├── diskMonitor/
│   ├── diskMonitor.bash
│   └── README.md
├── pingtest/
│   ├── pingtest.bash
│   └── README.md
└── systemHealth/
    ├── systemHealth.bash
    └── README.md
```

## Scripts

+ **backupVM** — Backs up KVM/Libvirt VM disk images by compressing each `.qcow2` file with `gzip`, with per-VM prompts and a live progress bar
+ **diskMonitor** — Monitors root partition disk space, renders an ASCII usage bar, and warns when usage crosses a configurable threshold
+ **pingtest** — Reads `/etc/hosts` and pings every host/VM entry found, reporting each as online or offline
+ **systemHealth** — Generates a system health report (uptime, CPU load, memory, disk usage, top processes, logged-in users) and appends it to a log file

# Step 1: Clone or download the repository

```
git clone https://github.com/aabel3/Linux-System-Bash-Scripts.git
cd Linux-System-Bash-Scripts
```

# Step 2: Pick a script folder

+ Each folder is self-contained: the script and its README live together
+ Open the folder's README for setup steps, requirements, and usage specific to that script

# Step 3: Make scripts executable

```
chmod +x <folder-name>/<script-name>.bash
```

# Step 4: Run with sudo where required

+ Every script currently in this repo requires root/sudo privileges
+ Run as: `sudo ./<script-name>.bash`

## Conventions

+ Every script includes a header comment block with purpose, usage, author, and date
+ Every script prints a welcome splash screen on startup
+ Scripts that require elevated privileges check for root and exit with an error (`>&2`) if not run as root/sudo
+ Each script folder contains exactly one script and one matching README

## Author

Avraham (Avi) Abel
