-include device/qcom/msm8953_64/msm8953_64.mk
-include device/asus/common/common.mk

#set default language for different sku
$(call inherit-product-if-exists, device/asus/Z01M/language.mk)

#$(call inherit-product, device/asus/Z01M/fingerprint/fingerprint.mk)

$(call inherit-product, device/asus/Z01M/fingerprint/fingerprint.mk)

SUPPORT_MODEM := true
SUPPORT_ASUS_OS_CTA := true

# Inherit asus applications
$(call inherit-product-if-exists, vendor/amax/products/amax_fone.mk)
#$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_n.mk)
PRODUCT_SHIPPING_API_LEVEL := 25

PRODUCT_NAME := Z01M
PRODUCT_DEVICE := Z01M
PRODUCT_BRAND := asus
PRODUCT_MODEL := ASUS_Z01MD
PRODUCT_MANUFACTURER := asus
TARGET_PROJECT ?= ZD552KL

#fhd xxhdpi
PRODUCT_AAPT_CONFIG := normal xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# NXP Smart Audio TFA9891 Support by WPI
NXP_SMARTPA_SUPPORT := tfa9891

# skip some unused app
REMOVE_UNUSED_APP := 1

TARGET_SYSTEM_PROP := device/qcom/msm8953_64/system.prop

TARGET_RELEASETOOLS_EXTENSIONS := device/qcom/common

#add ifaamanager
PRODUCT_BOOT_JARS += ifaamanager
PRODUCT_PACKAGES += ifaamanager

#this path is asus device path all make file can use this path!
ASUS_PATH=device/asus/Z01M

#if you want to add some packages please add here
#<ASUS-Alex1_wang20160307>add customize_service 
ifeq ($(TARGET_PRODUCT), Z01M)
# ASUS_BSP DTS HPX +++
PRODUCT_COPY_FILES += \
	device/asus/Z01M/DTS/Service/system/bin/dts_hpx_service:system/bin/dts_hpx_service \
	device/asus/Z01M/DTS/Service/system/lib/libdts_hpx_service_c.so:system/lib/libdts_hpx_service_c.so \
	device/asus/Z01M/DTS/Service/system/lib/libdts-dtscs.so:system/lib/libdts-dtscs.so \
	device/asus/Z01M/DTS/Service/system/lib/libdts-hpx-dtscs-conv.so:system/lib/libdts-hpx-dtscs-conv.so \
	device/asus/Z01M/DTS/Service/system/lib/libgnustl_shared.so:system/lib/libgnustl_shared.so \
	device/asus/Z01M/DTS/Service/system/lib/libgoogle-libprotobuf.so:system/lib/libgoogle-libprotobuf.so \
	device/asus/Z01M/DTS/Service/system/etc/dts/current_bluetooth44k:system/etc/dts/current_bluetooth44k \
	device/asus/Z01M/DTS/Service/system/etc/dts/current_bluetooth48k:system/etc/dts/current_bluetooth48k \
	device/asus/Z01M/DTS/Service/system/etc/dts/current_lineout:system/etc/dts/current_lineout \
	device/asus/Z01M/DTS/Service/system/etc/dts/current_speaker_off:system/etc/dts/current_speaker_off \
	device/asus/Z01M/DTS/Service/system/etc/dts/current_speaker_on:system/etc/dts/current_speaker_on \
	device/asus/Z01M/DTS/license/dts-eagle.lic:system/etc/dts/dts-eagle.lic \
	device/asus/Z01M/DTS/license/dts-m6m8-lic.key:system/etc/dts/dts-m6m8-lic.key \
	device/asus/Z01M/DTS/Service/system/etc/dts/default_config:system/etc/dts/default_config \
	device/asus/Z01M/DTS/Service/system/etc/dts/GEQ_configs:system/etc/dts/GEQ_configs

#dts---
endif
# updatelauncer config file
PRODUCT_COPY_FILES += \
	device/asus/Z01M/updatelauncher/devconf.json:system/etc/devconf.json \

#ASUS BSP +++  guochang_qiu add batttery id check
PRODUCT_COPY_FILES += \
     device/asus/Z01M/check_battery_id.sh:system/bin/check_battery_id \
#ASUS BSP ---  guochang_qiu add batttery id check

MODEM_FW_DIR := device/asus/Z01M/radio/modem
MODEM_CN_FW_DIR := device/asus/Z01M/radio/modem/cn
MODEM_OTHER_FW_DIR := device/asus/Z01M/radio/modem/other
MODEM_FAC_FW_DIR := device/asus/Z01M/firmware/factory
ifeq ($(TARGET_SKU), CN)
$(shell cp -f $(MODEM_CN_FW_DIR)/NON-HLOS.bin $(MODEM_FW_DIR))
else
$(shell cp -f $(MODEM_OTHER_FW_DIR)/NON-HLOS.bin $(MODEM_FW_DIR))
endif

ifeq ($(FACTORY), 1)
    $(shell cp -f $(MODEM_FAC_FW_DIR)/NON-HLOS.bin $(MODEM_FW_DIR))
endif

ifeq ($(TARGET_SKU),CN)
ADDITIONAL_DEFAULT_PROPERTIES += ro.contact.name=com.asus.cncontacts
endif
#ASUS_BSP terry_tao [Qcom][PS][][Remove]Disable qcom dpm process to prevent can't use FB live
ADDITIONAL_DEFAULT_PROPERTIES += persist.dpm.feature=10

#ASUS_BSP terry_tao enable omacp
ADDITIONAL_DEFAULT_PROPERTIES += persist.omacp.enable=true
ADDITIONAL_DEFAULT_PROPERTIES += persist.mmssupportcp.enable=true

ifeq ($(TARGET_SKU),CN)
PRODUCT_PROPERTY_OVERRIDES += ro.asus.cnlockscreen=true
PRODUCT_PROPERTY_OVERRIDES += ro.asus.cnuiversion=4.1
else
PRODUCT_PROPERTY_OVERRIDES += ro.asus.cnlockscreen=false
endif

#ASUS_BSP Robert_He panel alwayson full color property
PRODUCT_PROPERTY_OVERRIDES += ro.asus.alwayson.colormode=1

PRODUCT_SHIPPING_API_LEVEL := 25

#add for aptx, shilei_he, 2016.11.08
PRODUCT_PACKAGES += \
    libaptX-1.0.0-rel-Android21-ARMv7A \
    libaptXScheduler

# external tfa speaker
ifeq ($(strip $(NXP_SMARTPA_SUPPORT)),tfa9891)
PRODUCT_PACKAGES += \
libhal \
libtfa \
libsrv \
libtfa98xx \
climax \
tfatest \
tfamode

PRODUCT_COPY_FILES += \
device/asus/Z01M/TFA9891/settings/Tfa9891_mono.cnt:system/etc/settings/Tfa9891_mono.cnt \
device/asus/Z01M/TFA9891/settings/TFA9891N1A_Dec2015.config:system/etc/settings/TFA9891N1A_Dec2015.config \
device/asus/Z01M/TFA9891/settings/HDS_1026c.drc:system/etc/settings/HDS_1026c.drc \
device/asus/Z01M/TFA9891/settings/Hades_voice_DRC_1014.drc:system/etc/settings/Hades_voice_DRC_1014.drc \
device/asus/Z01M/TFA9891/settings/TFA9891N1A_N1A_11_1_34_NL3_HQLOUD.patch:system/etc/settings/TFA9891N1A_N1A_11_1_34_NL3_HQLOUD.patch \
device/asus/Z01M/TFA9891/settings/Hades_1027.speaker:system/etc/settings/Hades_1027.speaker \
device/asus/Z01M/TFA9891/settings/HDS_1026c.vstep:system/etc/settings/HDS_1026c.vstep \
device/asus/Z01M/TFA9891/settings/Hades_voice.vstep:system/etc/settings/Hades_voice.vstep

#ASUS_BSP +++ Zhengwei_Cai     "RK debug tool"
PRODUCT_PACKAGES += \
       preisp_io \
       preisp_debugger
#ASUS_BSP --- Zhengwei_Cai     "RK debug tool"
endif
