#!/bin/bash
# Add this as a deployment step with the arguments:
#$1: %{sourceDir}
#workingdir: %{buildDir}
rm -r ./packing

mkdir -p ./packing/IcoDroid/DEBIAN
cp $1/build_scripts/linux/control ./packing/IcoDroid/DEBIAN/control

mkdir -p ./packing/IcoDroid/usr/bin
cp -r ./deploy ./packing/IcoDroid/usr/IcoDroid/
ln -s ../IcoDroid/IcoDroid ./packing/IcoDroid/usr/bin/IcoDroid

cd ./packing
dpkg-deb --build ./IcoDroid
