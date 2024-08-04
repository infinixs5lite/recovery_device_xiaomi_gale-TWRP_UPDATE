#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/gale

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# System As Root
BOARD_SUPPRESS_SECURE_ERASE := true
BOARD_ROOT_EXTRA_FOLDERS += metadata

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    system \
    system_ext \
    vendor \
    product \
    boot \
    vbmeta_vendor \
    vbmeta_system
BOARD_USES_RECOVERY_AS_BOOT := 

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := gale
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 440

# Kernel
TARGET_NO_KERNEL := true
BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_KERNEL_CMDLINE += androidboot.force_normal_boot=1
BOARD_KERNEL_PAGESIZE := 2048
BOARD_RAMDISK_OFFSET := 0x07c08000
BOARD_KERNEL_TAGS_OFFSET := 0x0bc08000
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

# Kernel - prebuilt
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_INCLUDE_DTB_IN_BOOTIMG := 
endif

# Clang
TARGET_KERNEL_CLANG_COMPILE := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
BOARD_SUPER_PARTITION_SIZE := 7516192768
BOARD_SUPER_PARTITION_GROUPS := xiaomi_dynamic_partitions
BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext vendor product
BOARD_XIAOMI_DYNAMIC_PARTITIONS_SIZE := 7516192768

# Platform
TARGET_BOARD_PLATFORM := mt6769Z

# Assert
TARGET_OTA_ASSERT_DEVICE := gale,gust

# Recovery 
TARGET_NO_RECOVERY := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Vendor_boot recovery ramdisk
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := 
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := 

# Fstab
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab

# wipe
TARGET_RECOVERY_WIPE := $(DEVICE_PATH)/recovery/root/system/etc/recovery.wipe

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_VBMETA_SYSTEM := system product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_VBMETA_VENDOR := vendor
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 2
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 3

# Hack: prevent anti rollback
BOARD_USES_METADATA_PARTITION := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_FSCRYPT_POLICY := 2
PLATFORM_VERSION := 14
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Build Flags
TW_MAINTAINER := kelvin
TW_DEVICE_VERSION := V14
RECOVERY_VARIANT := twrp-12.1
ALLOW_MISSING_DEPENDENCIES := true
LC_ALL := "C"

# TWRP Configuration
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_EXCLUDE_APEX := true
TW_ENABLE_NOTCH := true
TW_ENABLE_QUICK_REBOOT := true
TW_INCLUDE_NANO_EDITOR := true
TW_INCLUDE_NANO := true
TW_INCLUDE_TWRPAPP := true
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true
TW_BATTERY_SYSFS_WAIT_SECONDS := 4
TW_FORCE_CPUINFO_FOR_DEVICE_ID := true
TW_THEME := portrait_hdpi
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2280
DEVICE_RESOLUTION := 1080 x 2280
TARGET_SCREEN_RATIO := 19:9
TW_SCREEN_RATIO := 19:9
ENABLE_SCHEDBOOST := true
BOARD_USE_CUSTOM_RECOVERY_FONT := "roboto_15x24.h"
TW_STATUS_ICONS_ALIGN := left
TW_CUSTOM_CPU_POS := "50"
TW_CUSTOM_CLOCK_POS := "290"

# Set panel refresh rate to 90 Hertz for smoother experience
# Possible supported frequencies: 30, 60, 90, 120
TW_FRAMERATE := 90

TW_CUSTOM_BATTERY_POS := "790"

# Allows you to map a custom keycode for power button, takes in a number, usually three digits
TW_CUSTOM_POWER_BUTTON := 107

# Python
TW_INCLUDE_PYTHON := true

# Brightness Screen
TW_NO_SCREEN_BLANK := true
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1200

# USB Configuration
TW_EXCLUDE_DEFAULT_USB_INIT := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.usb0/lun.%d/file
TW_HAS_MTP := true

# USB OTG
TW_USB_STORAGE := true

# Support /data/media
RECOVERY_SDCARD_ON_DATA := true

# LOGCAT
TARGET_USES_LOGD := true    
TWRP_INCLUDE_LOGCAT := true

# Format Use MKE2FS
TARGET_USES_MKE2FS := true

# FastbootD
TW_INCLUDE_FASTBOOTD := true

# Fuse
TW_INCLUDE_NTFS_3G    := true
TW_INCLUDE_FUSE_EXFAT := true
TW_INCLUDE_FUSE_NTFS  := true

# Props
TARGET_SYSTEM_PROP := $(DEVICE_PATH)/system.prop

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_PREPARE_DATA_MEDIA_EARLY := true

# Libresetprop & resetprop
TW_INCLUDE_LIBRESETPROP := true
TW_INCLUDE_RESETPROP := true

# Installer
AB_OTA_UPDATER := true
USE_RECOVERY_INSTALLER := true
RECOVERY_INSTALLER_PATH := $(DEVICE_PATH)/installer

