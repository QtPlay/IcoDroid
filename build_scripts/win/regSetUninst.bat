: %1: guid
: %2: maintanancetool path
: %3: base_key
: %4: node
: %5: 0: offline; 1: online
@echo off
IF "%5" == "0" (
	reg add "%~3\SOFTWARE\%~4\Windows\CurrentVersion\Uninstall\%~1" /f /v "NoModify" /t REG_DWORD /d 1
) ELSE (
	reg add "%~3\SOFTWARE\%~4\Windows\CurrentVersion\Uninstall\%~1" /f /v "UninstallString" /t REG_SZ /d "%~2 uninstallOnly=1"
)
