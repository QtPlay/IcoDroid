#-------------------------------------------------
#
# Project created by QtCreator 2015-12-01T14:35:33
#
#-------------------------------------------------

QT       += core gui widgets
CONFIG += C++11

#Download newest version from: https://github.com/Skycoder42/QPathEdit
win32: include(C:/C++Libraries/Qt/QPathEdit/qpathedit.pri)
else:mac: include(/Library/C++Libraries/Qt/QPathEdit/qpathedit.pri)
else:unix:include(/lib/C++Libraries/Qt/QPathEdit/qpathedit.pri)

#Download newest version from: https://github.com/Skycoder42/QtAutoUpdater
win32: include(C:/C++Libraries/Qt/QtAutoUpdater/qtautoupdater.pri)
else:mac: include(/Library/C++Libraries/Qt/QtAutoUpdater/qtautoupdater.pri)
else:unix:include(/lib/C++Libraries/Qt/QtAutoUpdater/qtautoupdater.pri)

TARGET = IcoDroid
VERSION = 1.1.1
TEMPLATE = app

DEFINES += "TARGET=\\\"$$TARGET\\\""
DEFINES += "VERSION=\\\"$$VERSION\\\""

win32 {
	RC_ICONS += ./icons/main.ico
	QMAKE_TARGET_COMPANY = "Skycoder Soft"
	QMAKE_TARGET_PRODUCT = "IcoDroid"
	QMAKE_TARGET_DESCRIPTION = $$QMAKE_TARGET_PRODUCT

	DEFINES += "COMPANY=\"\\\"$$QMAKE_TARGET_COMPANY\\\"\""
	DEFINES += "DISPLAY_NAME=\"\\\"$$QMAKE_TARGET_PRODUCT\\\"\""
} else:mac {
	ICON = ./icons/main.icns
	QMAKE_TARGET_BUNDLE_PREFIX = "com.SkycoderSoft."

	DEFINES += "COMPANY=\"\\\"Skycoder Soft\\\"\""
	DEFINES += "DISPLAY_NAME=\"\\\"IcoDroid\\\"\""
} else:unix {
	DEFINES += "COMPANY=\"\\\"Skycoder Soft\\\"\""
	DEFINES += "DISPLAY_NAME=\"\\\"IcoDroid\\\"\""

	QMAKE_LFLAGS += '-Wl,-rpath,\'\$$ORIGIN/lib\''
}


SOURCES += main.cpp\
        mainwindow.cpp \
    iconviewdockwidget.cpp \
    pixmapmodel.cpp

HEADERS  += mainwindow.h \
    iconviewdockwidget.h \
    pixmapmodel.h

FORMS    += mainwindow.ui \
	iconviewdockwidget.ui

DISTFILES += \
    .gitignore \
    LICENSE \
    README.md \
	icons/Fatcow-Farm-Fresh-Android.ico \
	icons/Visualpharm-Must-Have-Picture.ico \
    build_scripts/win/deploy.bat \
	build_scripts/win/translate.bat \
    icons/main.icns \
    build_scripts/mac/deploy.command \
    build_scripts/mac/translate.command \
    build_scripts/linux/translate.sh \
    build_scripts/linux/deploy.sh \
    build_scripts/mac/qt.conf \
    build_scripts/win/qt.conf \
    build_scripts/linux/qt.conf \
    build_scripts/win/install.bat \
	setup/package.xml \
	setup/shortcutPage.ui \
	build_scripts/mac/install.command \
	icons/main.ico \
    setup/install.js \
    build_scripts/linux/install.sh \
    icons/main.png \
    build_scripts/linux/config.xml \
    build_scripts/win/config.xml \
    build_scripts/mac/config.xml \
    setup/autoNextControl.js \
    build_scripts/win/regSetUninst.bat

RESOURCES += \
	icodroid_res.qrc

include(translations/translations.pri)
