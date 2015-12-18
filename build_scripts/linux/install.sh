#!/bin/bash
# Add this as a deployment step with the arguments:
#$1: "Qt Installer Framework install path"
#$2: %{sourceDir}
#workingdir: %{buildDir}

rm -r ./install
mkdir -p install/config
mkdir -p install/packages/com.SkycoderSoft.IcoDroid/meta
mv -f ./deploy install/packages/com.SkycoderSoft.IcoDroid/data
cd ./install

#config
cp $2/build_scripts/linux/config.xml ./config/
cp $2/setup/uninstallcontrol.js ./config/

#package
cp $2/build_scripts/linux/package.xml ./packages/com.SkycoderSoft.IcoDroid/meta/
cp $2/setup/install.js ./packages/com.SkycoderSoft.IcoDroid/meta/
cp $2/setup/shortcutPage.ui ./packages/com.SkycoderSoft.IcoDroid/meta/
cp $2/LICENSE ./packages/com.SkycoderSoft.IcoDroid/meta/
cp $2/icons/main.png ./packages/com.SkycoderSoft.IcoDroid/data/

$1/bin/binarycreator -f -c config/config.xml -p packages IcoDroid_1.0.0_setup.run
