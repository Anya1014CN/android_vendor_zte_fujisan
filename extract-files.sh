#!/bin/bash

set -e

DEVICE=fujisan
VENDOR=zte
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEVICE_TREE_DIR="${ROOT_DIR}/../android_device_zte_fujisan"
PROP_LIST="${DEVICE_TREE_DIR}/proprietary-files.txt"
DEST_DIR="${ROOT_DIR}/proprietary"

if [ ! -f "${PROP_LIST}" ]; then
    echo "Missing proprietary-files.txt at ${PROP_LIST}" >&2
    exit 1
fi

while IFS= read -r raw; do
    file="${raw%%#*}"
    file="${file#"${file%%[![:space:]]*}"}"
    file="${file%"${file##*[![:space:]]}"}"
    [ -z "${file}" ] && continue

    src="/system/${file}"
    if adb shell "[ -e '${src}' ]" </dev/null >/dev/null 2>&1; then
        :
    elif adb shell "[ -e '/${file}' ]" </dev/null >/dev/null 2>&1; then
        src="/${file}"
    else
        echo "Missing on device: ${file}" >&2
        continue
    fi

    mkdir -p "${DEST_DIR}/$(dirname "${file}")"
    adb pull "${src}" "${DEST_DIR}/${file}" </dev/null
done < "${PROP_LIST}"

"${ROOT_DIR}/setup-makefiles.sh"
