#!/vendor/bin/sh

getprop_int() {
    local value
    value="$(getprop "$1")"
    if [ -n "$value" ]; then
        echo "$value"
        return
    fi
    echo "$2"
}

write_if_exists() {
    if [ -e "$1" ]; then
        echo "$2" > "$1"
    fi
}

display_mode="$(getprop_int persist.vendor.fujisan.display_mode 4)"
single_display="$(getprop_int persist.vendor.fujisan.single_display_id 0)"
secondary_backlight="$(getprop_int persist.vendor.fujisan.secondary_backlight 60)"
hall_status="$(getprop_int persist.sys.zte.hallStatus 1)"
boot_completed="$(getprop sys.boot_completed)"
force_dual="$(getprop_int persist.vendor.fujisan.force_dual_screen 1)"

write_if_exists /sys/class/leds/lcd-backlight/brightness 200
write_if_exists /sys/class/graphics/fb0/blank 0
write_if_exists /proc/touchscreen/integrate_device_mode 0

if [ "$boot_completed" = "1" ]; then
    settings put system display_mode "$display_mode"
    settings put system hallC_display_mode "$display_mode"
    settings put system displayid_single_mode "$single_display"
    settings put system user_choose_displayid_single_mode "$single_display"
    settings put system dual_screen_dock_mode_screen_orientation_mode 0
    settings put secure switch_dispaly_screen_gesture_enabled 1
fi

if [ "$display_mode" = "4" ] && { [ "$hall_status" = "3" ] || [ "$force_dual" = "1" ]; }; then
    write_if_exists /sys/class/leds/lcd-backlight-2/brightness "$secondary_backlight"
    write_if_exists /sys/class/graphics/fb1/blank 0
    write_if_exists /sys/class/graphics/fb2/blank 0
else
    write_if_exists /sys/class/leds/lcd-backlight-2/brightness 0
    write_if_exists /sys/class/graphics/fb1/blank 4
    write_if_exists /sys/class/graphics/fb2/blank 4
fi
