#!/bin/bash
mountpoint="/mnt/windows-backup"
share="//192.168.100.32/Fede/Backup/srv-prod-2"

if ! mountpoint -q "$mountpoint"; then
    mount -t cifs "$share" "$mountpoint" -o credentials=/etc/smb-credentials,uid=$(id -u),gid=$(id -g),vers=3.0
fi
