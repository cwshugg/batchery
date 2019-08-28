@echo off

:: check if googledrivesync.exe is running
tasklist /fi "imagename eq googledrivesync.exe" 2>NUL | find /i /n "googledrivesync.exe">NUL

if "%errorlevel%"=="0" (
    :: if it is running, kill it
    echo   - Google Drive Sync is running. Killing it now...
    taskkill /im googledrivesync.exe /f
) else (
    :: if it's not running, start it
    echo   - Google Drive Sync is NOT running. Starting it now...
    cd C:\Program Files\Google\Drive\
    start googledrivesync.exe
    cd C:\Users\Connor\
)
