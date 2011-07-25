include theos/makefiles/common_warnallow.mk

TWEAK_NAME = iStartupMovie
iStartupMovie_FILES = Tweak.xm MovDelegate.m
iStartupMovie_FRAMEWORKS = Foundation MediaPlayer UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
