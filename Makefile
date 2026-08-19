ARCHS = arm64
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = dtje029mod
INSTALL_TARGET_PROCESSES = agar.io

dtje029mod_FILES = Tweak.x
dtje029mod_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unguarded-availability-new -Wno-error
dtje029mod_FRAMEWORKS = UIKit Foundation QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk
