# disk-space-alert-tool

> Linux disk usage monitoring script with threshold alerts and log output.

![Linux](https://img.shields.io/badge/Platform-Linux-blue?style=for-the-badge)
![Monitoring](https://img.shields.io/badge/Focus-Disk%20Monitoring-orange?style=for-the-badge)
![Shell](https://img.shields.io/badge/Bash-Script-green?style=for-the-badge)

---

## Overview

`disk-space-alert-tool` is a lightweight Bash script for Linux administrators to monitor filesystem usage and identify partitions that exceed a defined disk usage threshold.

It is useful for cron jobs, daily checks, basic monitoring, and incident prevention.

---

## Features

- Check filesystem usage on Linux servers
- Set custom alert threshold
- Exclude `tmpfs` and `devtmpfs`
- Write output to a log file
- Exit with non-zero status on alert condition
- Suitable for cron-based monitoring

---

## Use Cases

- Daily disk capacity checks
- Cron-based disk monitoring
- Prevent storage-related service failures
- Basic infrastructure monitoring
- SysAdmin portfolio project

---

## Requirements

- Linux server
- Bash shell
- `df`
- `awk`

---

## Installation

Clone the repository:

```bash
git clone https://github.com/I-MONDY-I/disk-space-alert-tool.git
cd disk-space-alert-tool
```
## Make the script executable:

```bash
chmod +x disk_space_alert.sh
```
## Usage
Run with the default threshold of 80%:

```bash
./disk_space_alert.sh
```
Arguments:

 Threshold percentage
 Log file path


Example Output
```
======================================================================
DISK SPACE ALERT TOOL
======================================================================
[2026-03-08 17:25:10] Hostname           : prod-db-01
[2026-03-08 17:25:10] Threshold          : 80%
[2026-03-08 17:25:10] Log file           : ./disk_space_alert.log

======================================================================
FILESYSTEM USAGE OVERVIEW
======================================================================
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   44G  4.5G  91% /
/dev/sdb1       200G  120G   70G  64% /data

======================================================================
ALERT CHECK
======================================================================
[2026-03-08 17:25:10] ALERT: One or more filesystems exceeded the threshold.
/dev/sda1        50G   44G  4.5G  91% /
```
