#!/usr/bin/env bash

# ==========================================================
# Disk Space Alert Tool
# Author: Ushan Perera
# Description:
# Checks Linux filesystem usage and alerts on threshold breach
# ==========================================================

set -euo pipefail

THRESHOLD="${1:-80}"
LOG_FILE="${2:-./disk_space_alert.log}"
HOSTNAME="$(hostname)"
DATE_NOW="$(date '+%Y-%m-%d %H:%M:%S')"
ALERT_FOUND=0

line() {
    printf '%*s\n' "${COLUMNS:-70}" '' | tr ' ' '='
}

section() {
    echo
    line
    echo "$1"
    line
}

log() {
    local message="$1"
    echo "[${DATE_NOW}] ${message}" | tee -a "$LOG_FILE"
}

validate_threshold() {
    if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]]; then
        echo "Threshold must be a numeric percentage."
        exit 1
    fi

    if (( THRESHOLD < 1 || THRESHOLD > 100 )); then
        echo "Threshold must be between 1 and 100."
        exit 1
    fi
}

check_filesystems() {
    df -hP --exclude-type=tmpfs --exclude-type=devtmpfs | awk -v threshold="$THRESHOLD" '
        NR==1 {next}
        {
            usage=$5
            gsub("%","",usage)
            if (usage+0 >= threshold) {
                print $0
            }
        }
    '
}

main() {
    validate_threshold

    section "DISK SPACE ALERT TOOL"
    log "Hostname           : $HOSTNAME"
    log "Threshold          : ${THRESHOLD}%"
    log "Log file           : $LOG_FILE"

    section "FILESYSTEM USAGE OVERVIEW"
    df -hP --exclude-type=tmpfs --exclude-type=devtmpfs | tee -a "$LOG_FILE"

    section "ALERT CHECK"
    ALERT_OUTPUT="$(check_filesystems)"

    if [[ -n "$ALERT_OUTPUT" ]]; then
        ALERT_FOUND=1
        log "ALERT: One or more filesystems exceeded the threshold."
        echo "$ALERT_OUTPUT" | tee -a "$LOG_FILE"
    else
        log "OK: No filesystems exceeded the threshold."
    fi

    section "SUMMARY"
    if (( ALERT_FOUND == 1 )); then
        log "Disk space alert check completed with warnings."
        exit 1
    else
        log "Disk space alert check completed successfully."
    fi
}

main "$@"
