#!/bin/bash
mountpoint="/mnt/windows-backup"

if mountpoint -q "$mountpoint"; then
    umount "$mountpoint"
fi
