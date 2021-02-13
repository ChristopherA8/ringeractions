TARGET := iphone:clang:latest:7.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = RingerActionsPrefs

RingerActionsPrefs_FILES = RACRootListController.m
RingerActionsPrefs_FRAMEWORKS = UIKit
RingerActionsPrefs_PRIVATE_FRAMEWORKS = Preferences
RingerActionsPrefs_INSTALL_PATH = /Library/PreferenceBundles
RingerActionsPrefs_EXTRA_FRAMEWORKS += CepheiPrefs Cephei
RingerActionsPrefs_CFLAGS = -fobjc-arc
RingerActionsPrefs_LIBRARIES = sparkapplist

include $(THEOS_MAKE_PATH)/bundle.mk
