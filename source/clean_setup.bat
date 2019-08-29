:: A batch script that prompts the user to choose the various locations for
:: the Windows Disk Cleanup tool to clean. Once the "clean.bat" script is run,
:: these chosen locations will be used for an automatic disk cleanup

@echo off

echo   - Launching Disk Cleanup...
msg * Check the locations you want "clean.bat" to run Disk Cleanup on.

:: launch disk cleanup with sageset
%windir%\system32\cleanmgr.exe /sageset:23