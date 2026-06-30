#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=fujisan
VENDOR=zte

MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n|--no-cleanup )
            CLEAN_VENDOR=false
            ;;
        -k|--kang )
            KANG="--kang"
            ;;
        -s|--section )
            SECTION="${2}"; shift
            CLEAN_VENDOR=false
            ;;
        * )
            SRC="${1}"
            ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        vendor/etc/data/dsi_config.xml|vendor/etc/data/netmgr_config.xml)
            python3 - "${2}" <<'PY'
from pathlib import Path
import sys
p = Path(sys.argv[1])
data = p.read_text(encoding='utf-8')
marker = '<?xml version="1.0" encoding="UTF-8"?>'
idx = data.find(marker)
if idx > 0:
    before = data[:idx].strip('\n')
    after = data[idx + len(marker):].lstrip('\n')
    new = marker + '\n'
    if before:
        new += before + '\n\n'
    new += after
    p.write_text(new, encoding='utf-8')
PY
            ;;
    esac
}

setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${ANDROID_ROOT}/device/${VENDOR}/${DEVICE}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
