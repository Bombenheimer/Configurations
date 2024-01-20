#!/bin/sh

set_brightness() {
  new_brightness=$(( $1 ))
  echo "echo $new_brightness | sudo tee /sys/devices/pci0000:00/0000:00:08.1/0000:02:00.0/backlight/amdgpu_bl0/brightness" | sudo sh
}

get_current_brightness() {
  cat /sys/devices/pci0000:00/0000:00:08.1/0000:02:00.0/backlight/amdgpu_bl0/brightness
}

while getopts "S:D:" opt; do
  case $opt in
    S)
      set_brightness "$OPTARG"
      ;;
    D)
      current_brightness=$(get_current_brightness)
      new_brightness=$((current_brightness - $OPTARG))
      set_brightness "$new_brightness"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done
