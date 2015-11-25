include theos/makefiles/common.mk

BUNDLE_NAME = panicLockProPrefs
panicLockProPrefs_FILES = panicLockProPrefs.mm
panicLockProPrefs_INSTALL_PATH = /Library/PreferenceBundles
panicLockProPrefs_FRAMEWORKS = UIKit
panicLockProPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/panicLockProPrefs.plist$(ECHO_END)
