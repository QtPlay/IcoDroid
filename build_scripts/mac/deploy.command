#!/bin/bash
# Add this as a deployment step with the arguments:
#$1: %{Qt:QT_INSTALL_DATA}
#$2: %{CurrentBuild:Type}
#$3: %{sourceDir}
#workingdir: %{buildDir}
rm -r ./deploy

mkdir -p deploy
cp -r ./IcoDroid.app ./deploy/
cd deploy
$1/bin/macdeployqt IcoDroid.app

mkdir -p ./IcoDroid.app/Contents/translations
cp $3/translations/*.qm ./IcoDroid.app/Contents/translations/
cp $1/translations/qt_de.qm ./IcoDroid.app/Contents/translations/
cp $1/translations/qt_en.qm ./IcoDroid.app/Contents/translations/
cp $1/translations/qtbase_de.qm ./IcoDroid.app/Contents/translations/
cp $1/translations/qtbase_en.qm ./IcoDroid.app/Contents/translations/

mkdir -p ./IcoDroid.app/Contents/Resources
cp $3/mac/qt.conf ./IcoDroid.app/Contents/Resources/qt.conf

#DMG-Creation done via appdmg: https://github.com/LinusU/node-appdmg
#check createDmg.txt for details

#EXECUTION:
#command:		%{buildDir}/deploy/IcoDroid.app/Contents/MacOS/IcoDroid
#arguments:
#workingdir:	%{buildDir}/deploy
