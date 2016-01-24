#!/bin/bash
# Add this as a deployment step with the arguments:
#$1: "Qt Installer Framework install path"
#$2: %{sourceDir}
#$3: 0 if create new, 1 if update
#workingdir: %{buildDir}

if [ "$3" -eq "0" ]; then
	rm -r ./install
else
	rm -r ./install/config
	rm -r ./install/packages
fi

mkdir -p install/config
mkdir -p install/packages/com.SkycoderSoft.IcoDroid/meta
mv -f ./deploy/IcoDroid.app install/packages/com.SkycoderSoft.IcoDroid/data
cd ./install

#config
cp $2/setup/config.xml ./config/
cp $2/setup/autoNextControl.js ./config/

#package
cp $2/setup/package.xml ./packages/com.SkycoderSoft.IcoDroid/meta/
cp $2/setup/install.js ./packages/com.SkycoderSoft.IcoDroid/meta/
cp $2/setup/ShortcutPage.ui ./packages/com.SkycoderSoft.IcoDroid/meta/
cp $2/setup/UserPage.ui ./packages/com.SkycoderSoft.IcoDroid/meta/
cp $2/setup/*.qm ./packages/com.SkycoderSoft.IcoDroid/meta/
cp $2/setup/LICENSE*.txt ./packages/com.SkycoderSoft.IcoDroid/meta/
cp $2/LICENSE.txt ./packages/com.SkycoderSoft.IcoDroid/meta/

# DEBUG - CREATE OFFLINE INSTALLER
#mkdir IcoDroid
#if [ "$3" -eq "0" ]; then
#	$1/bin/repogen -p ./packages ./IcoDroid/mac
#else
#	$1/bin/repogen --update-new-components -p ./packages ./IcoDroid/mac
#fi
#$1/bin/binarycreator -n -c ./config/config.xml -p ./packages IcoDroid_1.2.0_setup
#zip -r -9 IcoDroid_1.2.0_setup.app.zip IcoDroid_1.2.0_setup.app
$1/bin/binarycreator -f -c ./config/config.xml -p ./packages IcoDroid_1.2.0_setup
