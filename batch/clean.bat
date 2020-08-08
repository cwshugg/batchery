@echo off

:: ---------- delete all downloads ---------- ::
echo   - Wiping Downloads...
:: delete all files
del "%systemdrive%\Users\connor\Downloads\*" /s /f /q
:: delete all folders
for /d %%d in (C:\Users\connor\Downloads\*) Do rd /s /q "%%d"
:: switches used:
::   /s     deletes all files contained in subdirectories
::   /f     includes files with the read-only setting on
::   /q     "quiet", meaning there won't be any yes/no prompts

:: ---------- empty recycling bin ----------- ::
echo   - Wiping Recycling Bin...
:: delete all files and folders
del "%systemdrive%\$Recycle.bin\*" /s /f /q



:: -------- run the disk cleanup tool ------- ::
echo   - Launching Disk Cleanup with "clean_setup.bat" preferences...
%windir%\system32\cleanmgr.exe /sagerun:23