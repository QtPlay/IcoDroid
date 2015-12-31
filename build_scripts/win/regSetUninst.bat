: %1: guid
: %2: maintanancetool path
: %3: base_key
: %4: node
@echo off
reg add "%~3\SOFTWARE\%~4\Windows\CurrentVersion\Uninstall\%~1" /f /v "UninstallString" /t REG_SZ /d "%~2 uninstallOnly=1"
