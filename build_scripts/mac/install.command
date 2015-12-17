#!/bin/bash
# Add this as a deployment step with the arguments:
#$1: "Qt Installer Framework install path"
#$2: %{sourceDir}
#workingdir: %{buildDir}

rm -r ./install
mkdir -p install/config
mkdir -p install/packages/com.SkycoderSoft.IcoDroid/meta
mv -f ./deploy/IcoDroid.app install/packages/com.SkycoderSoft.IcoDroid/data
cd ./install

#config
cp $2/setup/config.xml ./config/
cp $2/setup/uninstallcontrol.qs ./config/

#package
cp $2/setup/package.xml ./packages/com.SkycoderSoft.IcoDroid/meta/
cp $2/setup/install.qs ./packages/com.SkycoderSoft.IcoDroid/meta/
cp $2/setup/shortcutPage.ui ./packages/com.SkycoderSoft.IcoDroid/meta/
cp $2/LICENSE ./packages/com.SkycoderSoft.IcoDroid/meta/

$1/bin/binarycreator -c config/config.xml -p packages IcoDroid_1.0.0_setup
