#!/bin/bash

SELECTION="$(printf "󰌾 Lock\n󰤄 Suspend\n󰍃 Log out\n Reboot\n Reboot to UEFI\n󰐥 Shutdown" | rofi -dmenu -p "Select an option: ")"

confirm_action() {
    local action="$1"
    CONFIRMATION="$(printf "No\nYes" | rofi -dmenu -p "$action?")"
    [[ "$CONFIRMATION" == *"Yes"* ]]
}

case $SELECTION in
    *"󰌾 Lock"*)
        swaylock --screenshots --effect-blur 7x5;;
    *"󰤄 Suspend"*)
        if confirm_action "Suspend"; then
            systemctl suspend
        fi;;
    *"󰍃 Log out"*)
        if confirm_action "Log out"; then
            swaymsg exit
        fi;;
    *" Reboot"*)
        if confirm_action "Reboot"; then
            systemctl reboot
        fi;;
    *" Reboot to UEFI"*)
        if confirm_action "Reboot to UEFI"; then
            systemctl reboot --firmware-setup
        fi;;
    *"󰐥 Shutdown"*)
        if confirm_action "Shutdown"; then
            systemctl poweroff
        fi;;
esac
