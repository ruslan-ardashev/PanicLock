export ARCHS = armv7 armv7s arm64
export TARGET = iphone:clang:8.4:8.4

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PanicLock8

PanicLock8_CFLAGS = -fobjc-arc
PanicLock8_LDFLAGS += -Wl,-segalign,4000

PanicLock8_FRAMEWORKS = UIKit Foundation

PanicLock8_LIBRARIES = applist activator

PanicLock8_FILES = $(wildcard Source/*.m)
PanicLock8_FILES += $(wildcard Source/*.mm)
PanicLock8_FILES += $(wildcard Source/*.x)
PanicLock8_FILES += $(wildcard Source/*.xm)


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += paniclockproios8prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
