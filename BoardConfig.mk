#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

DEVICE_PATH := device/xiaomi/emerald
KERNEL_PATH := $(DEVICE_PATH)-kernel

# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS := \
    boot \
    dtbo \
    system \
    system_ext \
    product \
    vendor \
    vbmeta \
    vendor_boot \
    vendor_dlkm \
    vbmeta_system \
    vbmeta_vendor

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a76
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := emerald
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 392

# DTBO
BOARD_KERNEL_SEPARATED_DTBO := true

# Boot Image
BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_KERNEL_BASE := 0x3fff8000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x07c88000
BOARD_RAMDISK_OFFSET := 0x26f08000
BOARD_RAMDISK_USE_LZ4 := true
BOARD_DTB_OFFSET := 0x07c88000

BOARD_BOOT_HEADER_VERSION := 4

BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 androidboot.tee_type=2
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_MKBOOTIMG_ARGS := --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)

# DTBO
BOARD_KERNEL_SEPARATED_DTBO := true

# VINTF
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
	$(DEVICE_PATH)/configs/vintf/framework_compatibility_matrix.xml \
	hardware/mediatek/vintf/mediatek_framework_compatibility_matrix.xml \
	hardware/xiaomi/vintf/xiaomi_framework_compatibility_matrix.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/configs/vintf/manifest.xml
DEVICE_MATRIX_FILE += $(DEVICE_PATH)/configs/vintf/compatibility_matrix.xml

# Kernel
BOARD_USES_GENERIC_KERNEL_IMAGE := true
TARGET_KERNEL_ARCH := arm64
INLINE_KERNEL_BUILDING := true
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_VERSION := 5.10

# Kernel prebuilt
BOARD_USES_DT := true
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtbs
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbs/dtbo.img

TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_KERNEL_SOURCE := $(KERNEL_PATH)/kernel-headers
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/Image.gz

# Kernel modules
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/vendor_ramdisk/modules.load))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(addprefix $(KERNEL_PATH)/vendor_ramdisk/, $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD))

# Also add recovery modules to vendor ramdisk
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/vendor_ramdisk/modules.load.recovery))
RECOVERY_MODULES := $(addprefix $(KERNEL_PATH)/vendor_ramdisk/, $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD))

# Prevent duplicated entries (to solve duplicated build rules problem)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(sort $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES) $(RECOVERY_MODULES))

# Vendor modules (installed to vendor_dlkm)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/vendor_dlkm/modules.load))
BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(KERNEL_PATH)/vendor_dlkm/*.ko)

# Partitions
BOARD_FLASH_BLOCK_SIZE := 16777216
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 8388608
BOARD_SUPER_PARTITION_SIZE := 7516192768
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_VENDOR_DLKMIMAGE := true

# Partitions (Dynamic)
BOARD_SUPER_PARTITION_GROUPS := mediatek_dynamic_partitions
BOARD_MEDIATEK_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor vendor_dlkm product system_ext
BOARD_MEDIATEK_DYNAMIC_PARTITIONS_SIZE := 7511998464 # BOARD_SUPER_PARTITION_SIZE - 4MB

BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# Platform
TARGET_BOARD_PLATFORM := mt6789
BOARD_HAS_MTK_HARDWARE := true
BOARD_VENDOR := xiaomi

# Power
TARGET_POWER_LIBPERFMGR_MODE_EXTENSION_LIB := //$(DEVICE_PATH):libperfmgr-ext-xiaomi

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/configs/props/vendor.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mt6789
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# SPL
VENDOR_SECURITY_PATCH := 2024-02-01

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag

BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VBMETA_SYSTEM := product system system_ext
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 1
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

BOARD_AVB_VBMETA_VENDOR := vendor
BOARD_AVB_VBMETA_VENDOR_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_VENDOR_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := 1
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX_LOCATION := 3

# VNDK
BOARD_VNDK_VERSION := current

# Wi-Fi
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER := NL80211
WIFI_DRIVER_FW_PATH_PARAM := "/dev/wmtWifi"
WIFI_DRIVER_FW_PATH_STA := "STA"
WIFI_DRIVER_FW_PATH_AP := "AP"
WIFI_DRIVER_FW_PATH_P2P := "P2P"
WIFI_DRIVER_STATE_CTRL_PARAM := "/dev/wmtWifi"
WIFI_DRIVER_STATE_ON := "1"
WIFI_DRIVER_STATE_OFF := "0"
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true

# Inherit the proprietary files
include vendor/xiaomi/emerald/BoardConfigVendor.mk
