: Add this as a deployment step with the arguments:
:%1: "Qt Installer Framework install path"
:%2: %{sourceDir}
:workingdir: %{buildDir}
@echo off

rmdir .\install /s /q
mkdir .\install\config
mkdir .\install\packages\com.SkycoderSoft.IcoDroid\meta
move /y .\deploy .\install\packages\com.SkycoderSoft.IcoDroid\data
cd .\install

:config
xcopy %2\build_scripts\win\config.xml .\config\* /y

:package
xcopy %2\setup\package.xml .\packages\com.SkycoderSoft.IcoDroid\meta\* /y
xcopy %2\setup\install.js .\packages\com.SkycoderSoft.IcoDroid\meta\* /y
xcopy %2\setup\shortcutPage.ui .\packages\com.SkycoderSoft.IcoDroid\meta\* /y
xcopy %2\LICENSE .\packages\com.SkycoderSoft.IcoDroid\meta\* /y

mkdir IcoDroid
%1\bin\repogen.exe -p ./packages ./IcoDroid/win_x64
%1\bin\binarycreator.exe -n -c ./config/config.xml -p ./packages IcoDroid_1.0.0_x64_setup.exe
