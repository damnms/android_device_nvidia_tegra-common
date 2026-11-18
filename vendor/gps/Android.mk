# Copyright (C) 2026 The LineageOS Project
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

# Broadcom GPS (BCM4752): daemon and legacy gps HAL module, loaded by
# android.hardware.gnss@1.0-impl through ro.hardware.gps=brcm.

LOCAL_PATH := $(call my-dir)
COMMON_GPS_PATH := ../../../../../vendor/nvidia/common/gps

include $(CLEAR_VARS)
LOCAL_MODULE               := glgps_nvidiaTegra2android
LOCAL_SRC_FILES_32         := $(COMMON_GPS_PATH)/bin32/glgps_nvidiaTegra2android
LOCAL_MULTILIB             := 32
LOCAL_MODULE_CLASS         := EXECUTABLES
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_OWNER         := nvidia
LOCAL_VENDOR_MODULE        := true
# SSLv3_client_method is gone from BoringSSL; the device adds a linker shim
# that provides it, which check_elf_files cannot see.
LOCAL_CHECK_ELF_FILES      := false
include $(BUILD_NVIDIA_COMMON_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE               := gps.brcm
LOCAL_SRC_FILES_32         := $(COMMON_GPS_PATH)/lib/hw/gps.brcm.so
LOCAL_MULTILIB             := 32
LOCAL_MODULE_SUFFIX        := .so
LOCAL_MODULE_CLASS         := SHARED_LIBRARIES
LOCAL_MODULE_TAGS          := optional
LOCAL_MODULE_OWNER         := nvidia
LOCAL_VENDOR_MODULE        := true
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_VINTF_FRAGMENTS      := android.hardware.gnss@1.0-service.xml
# The blob's DT_SONAME is gps.broadcommmandroid.so. The gnss HAL loads it by
# path (hw_get_module), so the name does not matter at runtime, but
# check_elf_files insists on SONAME == file name.
LOCAL_CHECK_ELF_FILES      := false
include $(BUILD_NVIDIA_COMMON_PREBUILT)
