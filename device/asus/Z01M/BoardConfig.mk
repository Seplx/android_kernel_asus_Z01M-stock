-include device/qcom/msm8953_64/BoardConfig.mk

TARGET_USE_MDTP := false

#Enable ODEX for userdebug and user eng builds
WITH_DEXPREOPT := true
# enable dex-preopt on prebuilt apks
WITH_DEXPREOPT_PREBUILT := true
WITH_DEXPREOPT_PIC := true
