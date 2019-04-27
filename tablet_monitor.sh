#!/bin/bash

# Configure the tablet as a second monitor settings

gtf 1280 800 60

xrandr --newmode "1280x800_60.00"  83.46  1280 1344 1480 1680  800 801 804 828  -HSync +Vsync

xrandr --addmode VIRTUAL1 1280x800_60.00

xrandr --output VIRTUAL1 --mode 1280x800_60.00 --left-of LVDS1

echo "Testing camarilla branch"
