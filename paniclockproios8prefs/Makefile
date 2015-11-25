include theos/makefiles/common.mk

BUNDLE_NAME = panicLockProiOS8Prefs
panicLockProiOS8Prefs_FILES = panicLockProiOS8Prefs.mm
panicLockProiOS8Prefs_INSTALL_PATH = /Library/PreferenceBundles
panicLockProiOS8Prefs_FRAMEWORKS = UIKit
panicLockProiOS8Prefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/panicLockProiOS8Prefs.plist$(ECHO_END)
