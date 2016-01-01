: Add this as a deployment step with the arguments:
:%1: "Qt Installer Framework install path"
:%2: %{sourceDir}
:%3: 0 if create new, 1 if update
:workingdir: %{buildDir}
@echo off

rmdir .\install /s /q
mkdir .\install\config
mkdir .\install\packages\com.SkycoderSoft.IcoDroid\meta
move /y .\deploy .\install\packages\com.SkycoderSoft.IcoDroid\data
cd .\install

:config
xcopy %2\build_scripts\win\config.xml .\config\* /y
xcopy %2\setup\autoNextControl.js .\config\* /y

:package
xcopy %2\setup\package.xml .\packages\com.SkycoderSoft.IcoDroid\meta\* /y
xcopy %2\setup\install.js .\packages\com.SkycoderSoft.IcoDroid\meta\* /y
xcopy %2\setup\shortcutPage.ui .\packages\com.SkycoderSoft.IcoDroid\meta\* /y
xcopy %2\LICENSE .\packages\com.SkycoderSoft.IcoDroid\meta\* /y
xcopy %2\build_scripts\win\regSetUninst.bat .\packages\com.SkycoderSoft.IcoDroid\data\* /y

mkdir IcoDroid
IF "%3" == "0" (
	%1\bin\repogen.exe -p ./packages ./IcoDroid/win_x64
) ELSE (
	%1\bin\repogen.exe --update-new-components -p ./packages ./IcoDroid/win_x64
)
%1\bin\binarycreator.exe -n -c ./config/config.xml -p ./packages IcoDroid_1.1.1_x64_setup.exe
