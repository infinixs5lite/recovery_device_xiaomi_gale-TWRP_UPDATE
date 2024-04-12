#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=gale
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
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

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"

#!/bin/bash

 export TARGET_DEVICE_ALT="gake"
 export OF_MAINTAINER="gake"
 export FOX_VARIANT="A14+"

 # Binaries & Tools
 export FOX_USE_BASH_SHELL=1
 export FOX_USE_NANO_EDITOR=1
 export FOX_USE_TAR_BINARY=1
 export FOX_USE_SED_BINARY=1
 export FOX_USE_XZ_UTILS=1
 export FOX_ASH_IS_BASH=1

 # OrangeFox Addons
 export FOX_ENABLE_APP_MANAGER=1
 export FOX_DELETE_AROMAFM=1

 # MIUI & Custom ROMs
 export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
 export OF_DEFAULT_KEYMASTER_VERSION=4.1

 # A/B partitioning
 export FOX_VIRTUAL_AB_DEVICE=1
 export OF_AB_DEVICE_WITH_RECOVERY_PARTITION=1
 export OF_IGNORE_LOGICAL_MOUNT_ERRORS=1
 export OF_ENABLE_LPTOOLS=1

 # Ensure that /sdcard is bind-unmounted before f2fs data repair or format
 export OF_UNBIND_SDCARD_F2FS=1

 # Number of list options before scrollbar creation
 export OF_OPTIONS_LIST_NUM=6

 # Store settings at /data/recovery instead of internal storage
 export FOX_USE_DATA_RECOVERY_FOR_SETTINGS=1

 # Flashlight & LEDs
 export OF_FL_PATH1=/system/etc/flashlight
 export OF_USE_GREEN_LED=0

 # Remove the loop block errors after flashing ZIPs (Workaround)
 export OF_LOOP_DEVICE_ERRORS_TO_LOG=1

 # Use LZ4 ramdisk compression as specified in BoardConfig.mk
 export OF_USE_LZ4_COMPRESSION=true

 # Security (Disables MTP & ADB during password prompt)
 export OF_ADVANCED_SECURITY=1

 # Screen settings
 export OF_SCREEN_H=2400
 export OF_STATUS_H=95
 export OF_STATUS_INDENT_LEFT=48
 export OF_STATUS_INDENT_RIGHT=48
 export OF_ALLOW_DISABLE_NAVBAR=0
 export OF_CLOCK_POS=1 # Left & Right

 # CCACHE
 export USE_CCACHE=1
 export CCACHE_EXEC=/usr/bin/ccache
 export CCACHE_MAXSIZE="32G"
 export CCACHE_DIR="/mnt/ccache"

 # Warn if CCACHE_DIR is an invalid directory
 if [ ! -d ${CCACHE_DIR} ];
  then
    echo "CCACHE Directory/Partition is not mounted at \"${CCACHE_DIR}\""
    echo "Please edit the CCACHE_DIR build variable or mount the directory."
 fi

 export LC_ALL="C"

 # Debugging
 ## export FOX_RESET_SETTINGS=0
 ## export FOX_INSTALLER_DEBUG_MODE=1
 ## export OF_DISPLAY_FORMAT_FILESYSTEMS_DEBUG_INFO=1
