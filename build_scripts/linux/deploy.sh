#!/bin/bash
# Add this as a deployment step with the arguments:
#$1: %{Qt:QT_INSTALL_DATA}
#$2: %{CurrentBuild:Type}
#$3: %{sourceDir}
#workingdir: %{buildDir}
rm -r ./deploy

mkdir -p deploy
cp -r ./IcoDroid ./deploy/
cd deploy

#.so files
mkdir ./lib
cp -a $1/lib/libQt5Widgets.so* ./lib/
cp -a $1/lib/libQt5Gui.so* ./lib/
cp -a $1/lib/libQt5Svg.so* ./lib/
cp -a $1/lib/libQt5Core.so* ./lib/
cp -a $1/lib/libQt5XcbQpa.so* ./lib/
cp -a $1/lib/libQt5DBus.so* ./lib/
cp -a $1/lib/libicui18n.so* ./lib/
cp -a $1/lib/libicuuc.so* ./lib/
cp -a $1/lib/libicudata.so* ./lib/

#plugins
mkdir ./plugins
cp -r $1/plugins/iconengines ./plugins/iconengines/
cp -r $1/plugins/imageformats ./plugins/imageformats/
cp -r $1/plugins/platforms ./plugins/platforms/
cp -r $1/plugins/platforminputcontexts ./plugins/platforminputcontexts/
cp -r $1/plugins/platformthemes ./plugins/platformthemes/
cp -r $1/plugins/xcbglintegrations ./plugins/xcbglintegrations/

#translations
mkdir ./translations
cp $3/translations/*.qm ./translations/
cp $1/translations/qt_de.qm ./translations/
cp $1/translations/qt_en.qm ./translations/
cp $1/translations/qtbase_de.qm ./translations/
cp $1/translations/qtbase_en.qm ./translations/

cp $3/build_scripts/linux/qt.conf ./qt.conf
cd ..

#EXECUTION:
#command:		%{buildDir}/deploy/IcoDroid
#arguments:
#workingdir:	%{buildDir}/deploy
