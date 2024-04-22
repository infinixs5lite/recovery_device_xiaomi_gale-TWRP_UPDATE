#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/gale

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Build hack
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_DUP_RULES := true

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
BOARD_USES_RECOVERY_AS_BOOT := true

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
TARGET_BOARD_PLATFORM := mt6768

# Assert
TARGET_OTA_ASSERT_DEVICE := gale,gust

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Fstab
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab

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

# TWRP Configuration
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_FRAMERATE := 90
TW_EXCLUDE_APEX := true

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

#SHRP Prop
# Official 
SHRP_OFFICIAL := true
# NOTE - Dont use '-' or blank spaces in flag values , otherwise it will create build errors or other bugs in recovery (Excluding SHRP_PATH,SHRP_REC). 
# Path of your SHRP Tree
SHRP_PATH := device/xiaomi/gale
# Maintainer name *
SHRP_MAINTAINER := nino
# Device codename *
SHRP_DEVICE_CODE := gale
# Recovery Type (It can be treble,normal,SAR) [Only for About Section] *
SHRP_REC_TYPE := Treble
# Recovery Type (It can be A/B or A_only) [Only for About Section] *
SHRP_DEVICE_TYPE := A/B
# SHRP Padding Flag (Only for rounded corner devices.) [Optional]
# You have to change these values according to your device's roundness.
SHRP_STATUSBAR_RIGHT_PADDING := 40
SHRP_STATUSBAR_LEFT_PADDING := 40
# For Notch devices [Optional]
SHRP_NOTCH := true
# SHRP Express, enables on-the-fly theme patching (also persistent) + persistent lock [Optional]
SHRP_EXPRESS := true
# SHRP Dark mode, use this flag to have dark theme set by default [Optional]
SHRP_DARK := true
# put this 0 if device has no EDL mode *
SHRP_EDL_MODE := 0
# Put your device's paths from fstab *
SHRP_EXTERNAL := /external_sd
SHRP_INTERNAL := /sdcard
SHRP_OTG := /usb_otg
# Put 0 to disable flashlight *
SHRP_FLASH := 1
# Max Brightness of LED [Optional]
SHRP_FLASH_MAX_BRIGHTNESS := 200
# Use this flag only if your device is A/B *
SHRP_AB := true
# Check your device's recovery path, dont use blindly
SHRP_REC := no_recovery_partition 
# Put 0 to disable flashlight
SHRP_FLASH := 1
SHRP_TORCH_PATH := "/sys/devices/platform/flashlights_ocp8132/torch_brightness"

#SHRP Addons
SHRP_EXTERNAL_ADDON_PATH := "device/xiaomi/gale/addon/"
SHRP_EXTERNAL_ADDON_1_NAME := "[MAGISK] Safetynet Fix"
SHRP_EXTERNAL_ADDON_1_INFO := "A magisk module which attempts to fix Safetynet"
SHRP_EXTERNAL_ADDON_1_FILENAME := "safetynet-fix.zip"
SHRP_EXTERNAL_ADDON_1_BTN_TEXT := "Flash"
SHRP_EXTERNAL_ADDON_1_SUCCESSFUL_TEXT := "Flashed Successfully"
SHRP_INC_IN_REC_EXTERNAL_ADDON_1 := true
SHRP_EXTERNAL_ADDON_2_NAME := "[MAGISK] Blur Enabler"
SHRP_EXTERNAL_ADDON_2_INFO := "A magisk module which Enables Blur in System"
SHRP_EXTERNAL_ADDON_2_FILENAME := "blur-enabler.zip"
SHRP_EXTERNAL_ADDON_2_BTN_TEXT := "Install"
SHRP_EXTERNAL_ADDON_2_SUCCESSFUL_TEXT := "Installed"
SHRP_INC_IN_REC_EXTERNAL_ADDON_2 := true
SHRP_EXTERNAL_ADDON_3_NAME := "[MAGISK] Nav-Bar Space Remover"
SHRP_EXTERNAL_ADDON_3_INFO := "Removes Space Under Keyboard"
SHRP_EXTERNAL_ADDON_3_FILENAME := "navbareliminator.zip"
SHRP_EXTERNAL_ADDON_3_BTN_TEXT := "Install"
SHRP_EXTERNAL_ADDON_3_SUCCESSFUL_TEXT := "Installed"
SHRP_INC_IN_REC_EXTERNAL_ADDON_3 := true
SHRP_EXTERNAL_ADDON_4_NAME := "Imei Backup"
SHRP_EXTERNAL_ADDON_4_INFO := "Takes Imei backup"
SHRP_EXTERNAL_ADDON_4_FILENAME := "Imei-Backup.zip"
SHRP_EXTERNAL_ADDON_4_BTN_TEXT := "Flash"
SHRP_EXTERNAL_ADDON_4_SUCCESSFUL_TEXT := "Flashed Successfully"
SHRP_INC_IN_REC_EXTERNAL_ADDON_4 := true
SHRP_EXTERNAL_ADDON_5_NAME := "Unlock Logo Remover"
SHRP_EXTERNAL_ADDON_5_INFO := "Removes Unlock Logo on Redmi Splash Screen"
SHRP_EXTERNAL_ADDON_5_FILENAME := "Unlock-Logo-Remover.zip"
SHRP_EXTERNAL_ADDON_5_BTN_TEXT := "Flash"
SHRP_EXTERNAL_ADDON_5_SUCCESSFUL_TEXT := "Flashed Successfully"
SHRP_INC_IN_REC_EXTERNAL_ADDON_5 := true
INC_IN_REC_ADDON_1 := true
INC_IN_REC_ADDON_2 := true
INC_IN_REC_ADDON_3 := true
INC_IN_REC_ADDON_4 := true
