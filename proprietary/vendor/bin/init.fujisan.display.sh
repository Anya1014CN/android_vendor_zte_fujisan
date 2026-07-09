#!/vendor/bin/sh

export PATH=/system/bin:/vendor/bin:/system/xbin

getprop_int() {
    local value
    value="$(getprop "$1")"
    if [ -n "$value" ]; then
        echo "$value"
        return
    fi
    echo "$2"
}

get_setting_int() {
    local namespace="$1"
    local key="$2"
    local fallback="$3"
    local value

    if [ ! -x "$settings_bin" ]; then
        echo "$fallback"
        return
    fi

    value="$("$settings_bin" get "$namespace" "$key" 2>/dev/null | tr -d '\r')"
    case "$value" in
        ""|null)
            echo "$fallback"
            ;;
        *)
            echo "$value"
            ;;
    esac
}

get_current_main_backlight() {
    local value

    if [ -r /sys/class/leds/lcd-backlight/brightness ]; then
        value="$(cat /sys/class/leds/lcd-backlight/brightness 2>/dev/null | tr -d '\r')"
        case "$value" in
            ''|*[!0-9]*)
                ;;
            *)
                echo "$value"
                return
                ;;
        esac
    fi

    echo "$secondary_backlight"
}

write_if_exists() {
    if [ -e "$1" ]; then
        echo "$2" > "$1"
    fi
}

sync_brightness_loop() {
    local display_mode
    local single_display
    local secondary_backlight
    local hall_status
    local force_dual
    local secondary_enabled
    local target_backlight
    local last_backlight

    last_backlight=""
    while true; do
        display_mode="$(getprop_int persist.vendor.fujisan.display_mode 1)"
        single_display="$(getprop_int persist.vendor.fujisan.single_display_id 0)"
        secondary_backlight="$(getprop_int persist.vendor.fujisan.secondary_backlight 60)"
        hall_status="$(getprop_int persist.sys.zte.hallStatus 1)"
        force_dual="$(getprop_int persist.vendor.fujisan.force_dual_screen 0)"
        secondary_enabled=0

        case "$display_mode" in
            2|4|8)
                if [ "$hall_status" = "3" ] || [ "$force_dual" = "1" ]; then
                    secondary_enabled=1
                fi
                ;;
            1)
                if [ "$single_display" = "1" ]; then
                    secondary_enabled=1
                fi
                ;;
        esac

        if [ "$secondary_enabled" = "1" ]; then
            if [ "$display_mode" = "1" ] && [ "$single_display" = "1" ]; then
                target_backlight="$secondary_backlight"
            else
                target_backlight="$(get_current_main_backlight)"
            fi
        else
            target_backlight=0
        fi

        if [ "$target_backlight" != "$last_backlight" ]; then
            write_if_exists /sys/class/leds/lcd-backlight-2/brightness "$target_backlight"
            last_backlight="$target_backlight"
        fi

        sleep 1
    done
}

if [ "${1:-}" = "--watch-brightness" ]; then
    sync_brightness_loop
fi

detect_secondary_fb() {
    local fb_cnt
    local file
    local line

    for fb_cnt in 1 2 3; do
        file="/sys/class/graphics/fb$fb_cnt/msm_fb_panel_info"
        if [ ! -f "$file" ]; then
            continue
        fi

        while IFS= read -r line; do
            case "$line" in
                *"is_pluggable"*1*)
                    echo "$fb_cnt"
                    return
                    ;;
            esac
        done < "$file"
    done

    echo "1"
}

display_mode="$(getprop_int persist.vendor.fujisan.display_mode 1)"
single_display="$(getprop_int persist.vendor.fujisan.single_display_id 0)"
secondary_backlight="$(getprop_int persist.vendor.fujisan.secondary_backlight 60)"
hall_status="$(getprop_int persist.sys.zte.hallStatus 1)"
boot_completed="$(getprop sys.boot_completed)"
force_dual="$(getprop_int persist.vendor.fujisan.force_dual_screen 0)"
settings_bin="/system/bin/settings"
synced_backlight="$(get_current_main_backlight)"
open_mode_fallback=2
secondary_state=0
secondary_enabled=0
secondary_fb="$(detect_secondary_fb)"
other_fb="2"

if [ "$secondary_fb" = "2" ]; then
    other_fb="1"
fi

if [ "$hall_status" = "3" ]; then
    open_mode_fallback="$display_mode"
fi

remembered_open_mode="$(get_setting_int system hallC_display_mode "$open_mode_fallback")"
dock_orientation="$(get_setting_int system dual_screen_dock_mode_screen_orientation_mode 2)"

if [ "$hall_status" = "3" ] && [ "$dock_orientation" = "2" ]; then
    dock_orientation=0
    remembered_open_mode="$display_mode"
fi

case "$display_mode" in
    2|4|8)
        if [ "$hall_status" = "3" ] || [ "$force_dual" = "1" ]; then
            secondary_enabled=1
        fi
        ;;
    1)
        if [ "$single_display" = "1" ]; then
            secondary_enabled=1
        fi
        ;;
esac

if [ "$secondary_enabled" = "1" ]; then
    secondary_state=2
fi

write_if_exists /proc/touchscreen/integrate_device_mode 0

if [ "$boot_completed" = "1" ] && [ -x "$settings_bin" ]; then
    "$settings_bin" put system display_mode "$display_mode"
    "$settings_bin" put system hallC_display_mode "$remembered_open_mode"
    "$settings_bin" put system displayid_single_mode "$single_display"
    "$settings_bin" put system user_choose_displayid_single_mode "$single_display"
    "$settings_bin" put system dual_screen_dock_mode_screen_orientation_mode "$dock_orientation"
    "$settings_bin" put system zte_secondary_lcd_state "$secondary_state"
    "$settings_bin" put system zte_secondary_display_power_state "$secondary_state"
    "$settings_bin" put secure switch_dispaly_screen_gesture_enabled 1
fi

if [ "$display_mode" = "1" ] && [ "$single_display" = "1" ]; then
    write_if_exists /sys/class/leds/lcd-backlight/brightness 0
    write_if_exists /sys/class/graphics/fb0/blank 4
    write_if_exists /sys/class/leds/lcd-backlight-2/brightness "$synced_backlight"
    write_if_exists "/sys/class/graphics/fb$secondary_fb/blank" 0
    write_if_exists "/sys/class/graphics/fb$other_fb/blank" 4
elif [ "$secondary_enabled" = "1" ]; then
    write_if_exists /sys/class/graphics/fb0/blank 0
    write_if_exists /sys/class/leds/lcd-backlight-2/brightness "$synced_backlight"
    write_if_exists "/sys/class/graphics/fb$secondary_fb/blank" 0
    write_if_exists "/sys/class/graphics/fb$other_fb/blank" 4
else
    write_if_exists /sys/class/graphics/fb0/blank 0
    write_if_exists /sys/class/leds/lcd-backlight-2/brightness 0
    write_if_exists "/sys/class/graphics/fb$secondary_fb/blank" 4
    write_if_exists "/sys/class/graphics/fb$other_fb/blank" 4
fi
