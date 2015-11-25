export ARCHS = armv7 armv7s arm64
export TARGET = iphone:clang:9.1:9.1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PanicLock7
PanicLock7_FRAMEWORKS = UIKit Foundation
PanicLock7_FILES = Tweak.xm
PanicLock7_LIBRARIES = applist activator

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += paniclockproprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
