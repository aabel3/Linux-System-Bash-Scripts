# pingtest.bash

A simple Bash script that reads `/etc/hosts` on Linux and pings every IPv4 host entry it finds, reporting whether each host or VM is online or offline.

## Features

- **Reads straight from /etc/hosts** — no separate host list to maintain, so it works with whatever hosts/VMs you've already added.
- **IPv4 detection** — matches lines that start with an IPv4 address and skips comments, `localhost`, and IPv6 entries automatically.
- **Per-host status** — sends a single ICMP ping to each address and reports it as online ✅ or offline 🚨.
- **Root privilege check** — exits with an error if not run as root/sudo.

## Requirements

- Linux system with `/etc/hosts` populated with the hosts/VMs to test
- Bash
- `ping`, `grep`, `cut` (installed by default on most distros)
- Root privileges (or `sudo`)

## Installation

This script lives in the `pingtest/` folder of the [Linux-System-Bash-Scripts](https://github.com/aabel3/Linux-System-Bash-Scripts) repository. Clone the repo and make the script executable:

```bash
git clone https://github.com/aabel3/Linux-System-Bash-Scripts.git
cd Linux-System-Bash-Scripts/pingtest
chmod +x pingtest.bash
```

## Configuration

Nothing in the script itself needs editing — it just reads whatever is already in `/etc/hosts`. Make sure every host or VM you want to test has an entry in the standard format:

```
192.168.245.10   vm-web01
192.168.245.11   vm-db01
```

- Column 1: IPv4 address
- Column 2: hostname
- Lines that don't start with an IPv4 address (comments, `localhost`, IPv6 entries) are skipped

## Usage

Run the script with root privileges:

```bash
sudo ./pingtest.bash
```

You will see a welcome banner, followed by a status line for each host found in `/etc/hosts`:

```
Linux host and Virtual Machine ping test
########################################
✅ vm-web01: online!
🚨 vm-db01: offline...
✅ webserver1: online!
```

## How It Works

1. Checks that the script is being run as root; exits if not.
2. Reads `/etc/hosts` line by line.
3. Uses a regex match to find lines that start with an IPv4 address, skipping everything else.
4. Extracts the IP address and hostname from each matching line.
5. Sends a single ping (`-c1`) to the address and prints an online/offline status based on the result.

## Notes

- Only one ping attempt is made per host, so a single dropped packet on an otherwise healthy host can show as offline.
- Useful for quickly checking connectivity to a group of KVM/libvirt VMs listed in `/etc/hosts`.

## Author

Avraham Abel — July 28, 2026
