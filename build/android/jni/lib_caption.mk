LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE:= libcaption
LOCAL_ARM_MODE := arm

LIBCAPTION_PATH := ../../../libcaption/src
LOCAL_C_INCLUDES := ../../../libcaption/caption

LOCAL_SRC_FILES := \
	$(LIBCAPTION_PATH)/caption.c \
	$(LIBCAPTION_PATH)/cea708.c \
	$(LIBCAPTION_PATH)/eia608_charmap.c \
	./libcaption/eia608_from_utf8.c \
	$(LIBCAPTION_PATH)/eia608.c \
	$(LIBCAPTION_PATH)/mpeg.c \
	$(LIBCAPTION_PATH)/scc.c \
	$(LIBCAPTION_PATH)/srt.c \
	$(LIBCAPTION_PATH)/utf8.c \
	$(LIBCAPTION_PATH)/vtt.c \
	$(LIBCAPTION_PATH)/xds.c

LOCAL_CFLAGS += -O3 -fstrict-aliasing

#include $(BUILD_STATIC_LIBRARY)
include $(BUILD_SHARED_LIBRARY)
