#!/bin/bash
# Add this as a deployment step with the arguments:
#$1: %{sourceDir}
#workingdir: %{buildDir}
rm -r ./packing

mkdir -p ./packing/IcoDroid/DEBIAN
cp $1/build_scripts/linux/control ./packing/IcoDroid/DEBIAN/control

mkdir -p ./packing/IcoDroid/usr/bin/IcoDroid

cp ./deploy/IcoDroid ./packing/IcoDroid/usr/bin/IcoDroid/IcoDroid
cp ./deploy/qt.conf ./packing/IcoDroid/usr/bin/IcoDroid/qt.conf
cp -r ./deploy/translations ./packing/IcoDroid/usr/bin/IcoDroid/translations/
cp -r ./deploy/lib/ ./packing/IcoDroid/usr/lib/
cp -r ./deploy/plugins/ ./packing/IcoDroid/usr/qt5_plugins/

cd ./packing
dpkg-deb --build ./IcoDroid
