: Add this as a deployment step with the arguments:
:%1: %{Qt:QT_INSTALL_BINS}
:%2: %{CurrentBuild:Type}
:%3: %{sourceDir}
:workingdir: %{buildDir}
@echo off

xcopy .\%2\IcoDroid.exe .\deploy\* /y
cd deploy
%1/windeployqt.exe --%2 ./IcoDroid.exe
xcopy %3\qt.conf .\* /y
xcopy %3\translations\*.qm .\translations\* /y

:EXECUTION:
:command:		%{buildDir}/AdminToolMain/deploy/AdminToolMain.exe
:arguments:
:workingdir:	%{buildDir}
