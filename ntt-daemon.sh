#!/bin/sh

# Exit script if ntt sleep is exited with Ctrl-C.
set -e

# Run a loop that notifies the user on every ping.
# ntt must be compiled and in path before this is run.
while [ true ]; do
    ntt sleep
    xrefresh -solid orange
    notify-send ping
    aplay -q bell.wav
    # Uncomment if you want to snapshot your desktop at ping time.
    # scrot "/tmp/screenshot-$(date +'%Y-%m-%dT%H:%M:%S%z').png"
done
