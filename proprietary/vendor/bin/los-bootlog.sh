#!/system/bin/sh

OUT=/cache/los-bootlog
mkdir -p "$OUT"
chmod 0777 "$OUT"

(
    echo "los-bootlog start $(date)"
    echo "cmdline: $(cat /proc/cmdline 2>/dev/null)"
    getprop
) > "$OUT/props-start.txt" 2>&1

/system/bin/logcat -b all -v threadtime -f "$OUT/logcat.txt" -r 4096 -n 4 >/dev/null 2>&1 &
LOGCAT_PID=$!

cat /proc/kmsg > "$OUT/kmsg.txt" 2>/dev/null &
KMSG_PID=$!

i=0
while [ "$i" -lt 240 ]; do
    {
        echo "===== tick $i $(date) ====="
        getprop init.svc.surfaceflinger
        getprop init.svc.hwcomposer-2-1
        getprop init.svc.gralloc-2-0
        getprop init.svc.hwservicemanager
        getprop init.svc.servicemanager
        getprop sys.boot_completed
        ps -A | grep -E "surfaceflinger|hwcomposer|gralloc|hwservicemanager|bootanim|zygote" || true
        ls -l /dev/graphics /dev/dri /dev/kgsl-3d0 2>/dev/null || true
    } >> "$OUT/state.txt" 2>&1
    sleep 1
    i=$((i + 1))
done

kill "$LOGCAT_PID" "$KMSG_PID" >/dev/null 2>&1

{
    echo "los-bootlog stop $(date)"
    getprop
} > "$OUT/props-stop.txt" 2>&1
