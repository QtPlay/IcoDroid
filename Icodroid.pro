#-------------------------------------------------
#
# Project created by QtCreator 2015-12-01T14:35:33
#
#-------------------------------------------------

QT       += core gui
CONFIG += C++11

#Download newest version from: https://github.com/Skycoder42/QPathEdit
win32: include(C:/C++Libraries/Qt/QPathEdit/qpathedit.pri)
else:mac: include(/Library/C++Libraries/Qt/QPathEdit/qpathedit.pri)
else:unix:include(/lib/C++Libraries/Qt/QPathEdit/qpathedit.pri)

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = IcoDroid
VERSION = 1.0.0
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

	QMAKE_LFLAGS += '-Wl,-rpath,\'\$$ORIGIN/../lib\''
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
    build_scripts/linux/qt.conf

RESOURCES += \
	icodroid_res.qrc

include(translations/translations.pri)
