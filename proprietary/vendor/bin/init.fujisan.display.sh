#!/vendor/bin/sh

[ -e /sys/class/leds/lcd-backlight/brightness ] && echo 200 > /sys/class/leds/lcd-backlight/brightness
[ -e /sys/class/leds/lcd-backlight-2/brightness ] && echo 0 > /sys/class/leds/lcd-backlight-2/brightness
[ -e /sys/class/graphics/fb0/blank ] && echo 0 > /sys/class/graphics/fb0/blank
[ -e /sys/class/graphics/fb1/blank ] && echo 4 > /sys/class/graphics/fb1/blank
[ -e /sys/class/graphics/fb2/blank ] && echo 4 > /sys/class/graphics/fb2/blank
[ -e /proc/touchscreen/integrate_device_mode ] && echo 0 > /proc/touchscreen/integrate_device_mode
