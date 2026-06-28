#!/bin/bash

set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEVICE_TREE_DIR="${ROOT_DIR}/../android_device_zte_fujisan"
PROP_LIST="${DEVICE_TREE_DIR}/proprietary-files.txt"

cat > "${ROOT_DIR}/fujisan-vendor.mk" <<'EOF_VENDOR_MK'
# Auto-generated vendor makefile for fujisan.

PRODUCT_COPY_FILES += \
EOF_VENDOR_MK

first=1
while IFS= read -r raw; do
    file="${raw%%#*}"
    file="${file#"${file%%[![:space:]]*}"}"
    file="${file%"${file##*[![:space:]]}"}"
    [ -z "${file}" ] && continue

    if [ ${first} -eq 0 ]; then
        printf " \\\\\n" >> "${ROOT_DIR}/fujisan-vendor.mk"
    fi
    printf "    vendor/zte/fujisan/proprietary/%s:%s" "${file}" "${file}" >> "${ROOT_DIR}/fujisan-vendor.mk"
    first=0
done < "${PROP_LIST}"
printf "\n" >> "${ROOT_DIR}/fujisan-vendor.mk"

cat > "${ROOT_DIR}/fujisan-vendor-blobs.mk" <<'EOF_BLOBS_MK'
LOCAL_PATH := vendor/zte/fujisan
EOF_BLOBS_MK

cat > "${ROOT_DIR}/fujisan-vendor-board.mk" <<'EOF_BOARD_MK'
include vendor/zte/fujisan/BoardConfigVendor.mk
EOF_BOARD_MK
