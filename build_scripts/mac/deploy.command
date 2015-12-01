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
cp $1/translations/qt_*.qm ./IcoDroid.app/Contents/translations/
rm ./IcoDroid.app/Contents/translations/qt_help*.qm
cp $1/translations/qtbase_*.qm ./IcoDroid.app/Contents/translations/

mkdir -p ./IcoDroid.app/Contents/Resources
cp $3/qt.conf ./IcoDroid.app/Contents/Resources/qt.conf

$1/bin/macdeployqt IcoDroid.app -dmg

#EXECUTION:
#command:		%{buildDir}/deploy/IcoDroid.app/Contents/MacOS/IcoDroid
#arguments:
#workingdir:	%{buildDir}
