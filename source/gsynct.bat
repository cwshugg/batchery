@echo off

:: process time input
set time=%1
if %1.==. (set time=3600)
:: process shutdown input
set shutdown=%2
if %2.==. (set shutdown="")

:: check if googledrivesync.exe is running
tasklist /fi "imagename eq googledrivesync.exe" 2>NUL | find /i /n "googledrivesync.exe">NUL

if "%errorlevel%"=="0" (
    :: if it is running, kill it
    echo   - Google Drive Sync is running. Killing it now...
    taskkill /im googledrivesync.exe /f
    
    :: if the shutdown option was given, shut off the computer
    if "%shutdown%"=="-s" (
        echo   - Shutdown switch was given: Shutting down in 10 seconds...
        timeout 10
        shutdown /s /c "User-chosen Shutdown through 'gsynct.bat' script"
    )
) else (
    :: if it's not running, start it
    echo   - Google Drive Sync is NOT running. Starting it now...
    cd C:\Program Files\Google\Drive\
    start googledrivesync.exe
    cd C:\Users\Connor\
    
    if "%shutdown%"=="-s" (
        echo   - Shutdown switch was given: computer will shut down upon completion of this script
    )
    
    :: wait %time%, then run the script again to kill it
    echo   - Process will be killed in %time% seconds.
    timeout %time%
    call C:\Users\Connor\batch\gsynct.bat 0 %shutdown%
)
