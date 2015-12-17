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
xcopy %2\build_scripts\win\uninstallcontrol.qs .\config\* /y

:package
xcopy %2\build_scripts\win\package.xml .\packages\com.SkycoderSoft.IcoDroid\meta\* /y
xcopy %2\build_scripts\win\install.qs .\packages\com.SkycoderSoft.IcoDroid\meta\* /y
xcopy %2\build_scripts\win\shortcutPage.ui .\packages\com.SkycoderSoft.IcoDroid\meta\* /y
xcopy %2\LICENSE .\packages\com.SkycoderSoft.IcoDroid\meta\* /y

%1\bin\binarycreator.exe -c config\config.xml -p packages IcoDroid_1.0.0_x64_setup.exe
