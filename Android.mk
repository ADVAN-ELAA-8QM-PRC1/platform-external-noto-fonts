# Copyright (C) 2013 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

NOTO_DIR := $(call my-dir)

# Use full Noto Sans Japanese font on extended footprint
ifeq ($(EXTENDED_FONT_FOOTPRINT),true)
FONT_NOTOSANS_JP_FULL := true
endif

# We have to use BUILD_PREBUILT instead of PRODUCT_COPY_FILES,
# to copy over the NOTICE file.
#############################################################################
# $(1): The source file name in LOCAL_PATH.
#       It also serves as the module name and the dest file name.
#############################################################################
define build-one-font-module
$(eval include $(CLEAR_VARS))\
$(eval LOCAL_MODULE := $(1))\
$(eval LOCAL_SRC_FILES := $(1))\
$(eval LOCAL_MODULE_CLASS := ETC)\
$(eval LOCAL_MODULE_TAGS := optional)\
$(eval LOCAL_MODULE_PATH := $(TARGET_OUT)/fonts)\
$(eval include $(BUILD_PREBUILT))
endef


#############################################################################
# First "build" the Noto CJK fonts, which have their own directory and
# license. These are only included in EXTENDED_FONT_FOOTPRINT builds.
#############################################################################

ifeq ($(EXTENDED_FONT_FOOTPRINT),true)
LOCAL_PATH := $(NOTO_DIR)/cjk

font_src_files := \
    NotoSansKR-Regular.otf \
    NotoSansSC-Regular.otf \
    NotoSansTC-Regular.otf

$(foreach f, $(font_src_files), $(call build-one-font-module, $(f)))
font_src_files :=

#############################################################################
# Include NotoSansJP, or a subset.
#############################################################################

ifeq ($(FONT_NOTOSANS_JP_FULL),true)
noto_sans_jp_src := NotoSansJP-Regular.otf
else
noto_sans_jp_src := NotoSansJP-Regular-Subsetted.otf
endif # FONT_NOTOSANS_JP_FULL

include $(CLEAR_VARS)
LOCAL_MODULE := NotoSansJP-Regular.otf
LOCAL_SRC_FILES := $(noto_sans_jp_src)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT)/fonts
include $(BUILD_PREBUILT)

noto_sans_jp_src :=

endif # EXTENDED_FONT_FOOTPRINT


#############################################################################
# Now "build" the rest of the fonts, which live in a separate subdirectory.
#############################################################################
LOCAL_PATH := $(NOTO_DIR)/other
NOTO_DIR :=

#############################################################################
# The following fonts are included in all builds.
#############################################################################
font_src_files := \
    NotoSerif-Regular.ttf \
    NotoSerif-Bold.ttf \
    NotoSerif-Italic.ttf \
    NotoSerif-BoldItalic.ttf

#############################################################################
# The following fonts are only included in EXTENDED_FONT_FOOTPRINT builds.
#############################################################################
ifeq ($(EXTENDED_FONT_FOOTPRINT),true)
font_src_files += \
    NotoSansBalinese-Regular.ttf \
    NotoSansBamum-Regular.ttf \
    NotoSansBatak-Regular.ttf \
    NotoSansBuginese-Regular.ttf \
    NotoSansBuhid-Regular.ttf \
    NotoSansCanadianAboriginal-Regular.ttf \
    NotoSansCham-Regular.ttf \
    NotoSansCham-Bold.ttf \
    NotoSansCherokee-Regular.ttf \
    NotoSansCoptic-Regular.ttf \
    NotoSansGlagolitic-Regular.ttf \
    NotoSansGujarati-Regular.ttf \
    NotoSansGujarati-Bold.ttf \
    NotoSansGujaratiUI-Regular.ttf \
    NotoSansGujaratiUI-Bold.ttf \
    NotoSansGurmukhi-Regular.ttf \
    NotoSansGurmukhi-Bold.ttf \
    NotoSansGurmukhiUI-Regular.ttf \
    NotoSansGurmukhiUI-Bold.ttf \
    NotoSansHanunoo-Regular.ttf \
    NotoSansJavanese-Regular.ttf \
    NotoSansKayahLi-Regular.ttf \
    NotoSansLepcha-Regular.ttf \
    NotoSansLimbu-Regular.ttf \
    NotoSansLisu-Regular.ttf \
    NotoSansMandaic-Regular.ttf \
    NotoSansMeeteiMayek-Regular.ttf \
    NotoSansMongolian-Regular.ttf \
    NotoSansNewTaiLue-Regular.ttf \
    NotoSansNKo-Regular.ttf \
    NotoSansOlChiki-Regular.ttf \
    NotoSansOriya-Regular.ttf \
    NotoSansOriya-Bold.ttf \
    NotoSansOriyaUI-Regular.ttf \
    NotoSansOriyaUI-Bold.ttf \
    NotoSansRejang-Regular.ttf \
    NotoSansSaurashtra-Regular.ttf \
    NotoSansSinhala-Regular.ttf \
    NotoSansSinhala-Bold.ttf \
    NotoSansSundanese-Regular.ttf \
    NotoSansSylotiNagri-Regular.ttf \
    NotoSansSyriacEstrangela-Regular.ttf \
    NotoSansTagbanwa-Regular.ttf \
    NotoSansTaiLe-Regular.ttf \
    NotoSansTaiTham-Regular.ttf \
    NotoSansTaiViet-Regular.ttf \
    NotoSansThaana-Regular.ttf \
    NotoSansThaana-Bold.ttf \
    NotoSansTibetan-Regular.ttf \
    NotoSansTifinagh-Regular.ttf \
    NotoSansVai-Regular.ttf \
    NotoSansYi-Regular.ttf
endif # EXTENDED_FONT_FOOTPRINT

#############################################################################
# The following fonts are excluded from SMALLER_FONT_FOOTPRINT builds.
#############################################################################
ifneq ($(SMALLER_FONT_FOOTPRINT),true)
font_src_files += \
    NotoSansBengali-Regular.ttf \
    NotoSansBengali-Bold.ttf \
    NotoSansBengaliUI-Regular.ttf \
    NotoSansBengaliUI-Bold.ttf \
    NotoSansDevanagari-Regular.ttf \
    NotoSansDevanagari-Bold.ttf \
    NotoSansDevanagariUI-Regular.ttf \
    NotoSansDevanagariUI-Bold.ttf \
    NotoSansEthiopic-Regular.ttf \
    NotoSansEthiopic-Bold.ttf \
    NotoSansKannada-Regular.ttf \
    NotoSansKannada-Bold.ttf \
    NotoSansKannadaUI-Regular.ttf \
    NotoSansKannadaUI-Bold.ttf \
    NotoSansKhmer-Regular.ttf \
    NotoSansKhmer-Bold.ttf \
    NotoSansKhmerUI-Regular.ttf \
    NotoSansKhmerUI-Bold.ttf \
    NotoSansLao-Regular.ttf \
    NotoSansLao-Bold.ttf \
    NotoSansLaoUI-Regular.ttf \
    NotoSansLaoUI-Bold.ttf \
    NotoSansMalayalam-Regular.ttf \
    NotoSansMalayalam-Bold.ttf \
    NotoSansMalayalamUI-Regular.ttf \
    NotoSansMalayalamUI-Bold.ttf \
    NotoSansMyanmar-Regular.ttf \
    NotoSansMyanmar-Bold.ttf \
    NotoSansMyanmarUI-Regular.ttf \
    NotoSansMyanmarUI-Bold.ttf \
    NotoSansTamil-Regular.ttf \
    NotoSansTamil-Bold.ttf \
    NotoSansTamilUI-Regular.ttf \
    NotoSansTamilUI-Bold.ttf \
    NotoSansTelugu-Regular.ttf \
    NotoSansTelugu-Bold.ttf \
    NotoSansTeluguUI-Regular.ttf \
    NotoSansTeluguUI-Bold.ttf \
    NotoSansThai-Regular.ttf \
    NotoSansThai-Bold.ttf \
    NotoSansThaiUI-Regular.ttf \
    NotoSansThaiUI-Bold.ttf
endif # !SMALLER_FONT_FOOTPRINT

#############################################################################
# The following fonts are excluded from MINIMAL_FONT_FOOTPRINT builds.
#############################################################################
ifneq ($(MINIMAL_FONT_FOOTPRINT),true)
font_src_files += \
    NotoNaskhArabic-Regular.ttf \
    NotoNaskhArabic-Bold.ttf \
    NotoNaskhArabicUI-Regular.ttf \
    NotoNaskhArabicUI-Bold.ttf \
    NotoSansArmenian-Regular.ttf \
    NotoSansArmenian-Bold.ttf \
    NotoSansGeorgian-Regular.ttf \
    NotoSansGeorgian-Bold.ttf \
    NotoSansHebrew-Regular.ttf \
    NotoSansHebrew-Bold.ttf \
    NotoSansSymbols-Regular-Subsetted.ttf
endif # !MINIMAL_FONT_FOOTPRINT

$(foreach f, $(font_src_files), $(call build-one-font-module, $(f)))
build-one-font-module :=
font_src_files :=

#############################################################################
# Use Noto Color Emoji with all the flags on EXTENDED_FONT_FOOTPRINT builds,
# but without it on other builds. On SMALLER_FONT_FOOTPRINT devices, no
# color emoji font is included.
#############################################################################
ifneq ($(SMALLER_FONT_FOOTPRINT),true)

ifeq ($(EXTENDED_FONT_FOOTPRINT),true)
color_emoji_src := NotoColorEmoji.ttf
else  # !EXTENDED_FONT_FOOTPRINT
color_emoji_src := NotoColorEmoji-Subsetted.ttf
endif # EXTENDED_FONT_FOOTPRINT

include $(CLEAR_VARS)
LOCAL_MODULE := NotoColorEmoji.ttf
LOCAL_SRC_FILES := $(color_emoji_src)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT)/fonts
include $(BUILD_PREBUILT)

color_emoji_src :=

endif # !SMALLER_FONT_FOOTPRINT
