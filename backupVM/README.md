# backupVM.bash

A simple interactive Bash script for backing up KVM/libvirt virtual machine disk images (`.qcow2`) on Linux. It automatically detects any VM images present, prompts you individually for each one, and compresses the ones you choose with `gzip` while showing a live `#` progress bar.

## Features

- **Auto-detects VMs** — scans the libvirt images directory for any `*.qcow2` file, so it works with any VM name (not hardcoded to specific VMs).
- **Per-VM prompts** — asks `Would you like to backup VM <name>? (y/n)` for each VM found, so you can choose exactly which ones to back up in a single run.
- **Live progress bar** — prints `#` characters while each backup is running, so you can see it's still working.
- **Root privilege check** — exits with an error if not run as root/sudo.
- **No-VMs safeguard** — exits with an error if no `.qcow2` images are found in the source directory.
- **Safe path handling** — quotes all file paths to handle VM names or paths with spaces.

## Requirements

- Linux system running libvirt/KVM
- Bash
- `gzip`
- Root privileges (or `sudo`)
- VM disk images stored as `.qcow2` files

## Installation

This script lives in the `backupVM/` folder of the [Linux-System-Bash-Scripts](https://github.com/aabel3/Linux-System-Bash-Scripts) repository. Clone the repo and make the script executable:

```bash
git clone https://github.com/aabel3/Linux-System-Bash-Scripts.git
cd Linux-System-Bash-Scripts/backupVM
chmod +x backupVM.bash
```

## Configuration

The script currently points at these paths — open `backupVM.bash` and edit them if your environment is different:

```bash
img_path="/var/lib/libvirt/images/"
backup_path="/home/aabel/VirtualMachine-Backups/"
```

- `img_path` — directory where your VM `.qcow2` images are stored.
- `backup_path` — directory where compressed backups (`.qcow2.gz`) will be written. Make sure this directory exists before running the script.

## Usage

Run the script with root privileges:

```bash
sudo ./backupVM.bash
```

You will see a welcome banner, followed by a prompt for each detected VM:

```
KVM/Libvirt virtual machine backups
###################################
Would you like to backup VM deb1? (y/n): y
Backing up VM: deb1
deb1 [########] done
deb1: Backup successfully completed!
Would you like to backup VM deb2? (y/n): n
Skipping over VM deb2
Would you like to backup VM webserver1? (y/n): y
Backing up VM: webserver1
webserver1 [######] done
webserver1: Backup successfully completed!
```

Backups are saved to `backup_path` as `<vm-name>.qcow2.gz`.

## How It Works

1. Checks that the script is being run as root; exits if not.
2. Scans `img_path` for all `.qcow2` files and builds a list of available VM names; exits if none are found.
3. Loops through the list and prompts `y`/`n` for each VM, re-prompting on invalid input.
4. For each VM answered `y`, runs `gzip` in the background, displays a `#` progress bar until it finishes, then confirms completion.

## Author

Avraham (Avi) Abel — July 27, 2026
