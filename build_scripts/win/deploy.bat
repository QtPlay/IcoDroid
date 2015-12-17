: Add this as a deployment step with the arguments:
:%1: %{Qt:QT_INSTALL_BINS}
:%2: %{CurrentBuild:Type}
:%3: %{sourceDir}
:workingdir: %{buildDir}
@echo off
rmdir .\deploy /s /q

xcopy .\%2\IcoDroid.exe .\deploy\* /y
cd deploy
%1/windeployqt.exe --%2 ./IcoDroid.exe

cd translations
ren *_de.qm *_de.mqtmp
ren *_en.qm *_en.mqtmp
del *.qm
ren *.mqtmp *.qm
cd ..

xcopy %3\build_scripts\win\qt.conf .\* /y
xcopy %3\icons\main.ico .\* /y
xcopy %3\translations\*.qm .\translations\* /y

:EXECUTION:
:command:		%{buildDir}/AdminToolMain/deploy/AdminToolMain.exe
:arguments:
:workingdir:	%{buildDir}
