#-------------------------------------------------
#
# Project created by QtCreator 2015-12-01T14:35:33
#
#-------------------------------------------------

QT       += core gui

#Download newest version from: https://github.com/Skycoder42/QPathEdit
win32: include(C:/C++Libraries/Qt/QPathEdit/qpathedit.pri)
else:mac: include(/Library/C++Libraries/Qt/QPathEdit/qpathedit.pri)

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
}


SOURCES += main.cpp\
        mainwindow.cpp \
    iconviewdockwidget.cpp

HEADERS  += mainwindow.h \
    iconviewdockwidget.h

FORMS    += mainwindow.ui \
    iconviewdockwidget.ui

DISTFILES += \
    .gitignore \
    LICENSE \
    README.md \
	icons/Fatcow-Farm-Fresh-Android.ico \#original icon from: http://www.fatcow.com/free-icons
	icons/Visualpharm-Must-Have-Picture.ico \#original icon from: http://www.visualpharm.com/
    build_scripts/win/deploy.bat \
    build_scripts/win/translate.bat \
    qt.conf \
    icons/main.icns \
    build_scripts/mac/deploy.command \
    build_scripts/mac/translate.command \
    build_scripts/mac/dmgInfo.json \
    build_scripts/mac/createDmg.txt \
    build_scripts/mac/background.png

RESOURCES += \
	icodroid_res.qrc

include(translations/translations.pri)
