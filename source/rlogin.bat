:: This is an extensive batch script written to assist with accessing SSH
:: clients: connecting, moving files on/off, etc. Makes use of SSH and SCP to
:: do most of the work.
::
:: The "global" variables defined a few lines down can be used to adjust
:: where to connect (user@address), the default save directory on Windows, and
:: your home directory on the remote server.
::
:: To get started, call this script in the command line like so:
::      "rlogin help"
::
:: -----
:: Written by Connor Shugg
:: Used for CS 2505/2506/3214 at Virginia Tech

@echo off
:: make all variables local to the script
:: (EnableDelayedExpansion: https://ss64.com/nt/delayedexpansion.html)
setlocal EnableDelayedExpansion

echo.
echo -----===== [VT CS Remote Login Helper Script] =====-----

:: set up "global" variables used by most actions
set g_user="<username>"
set g_address="<rlogin address>"
set g_portal_address="<rlogin portal address>"
set g_homedir="<path to home directory on server>"
set g_defaultdir="<default directory on windows>"

:: get the first input argument and format it
set action=%1
if [%1]==[] (
    set action="in"
) else (
    set action="%action%"
)

:: get the second input argument (if needed) and format it
set input=%2
if [%2]==[] (
    set input=""
) else (
    set input="%input%"
)

:: get the third input argument (if needed) and format it
set input2=%3
if [%3]==[] (
    set input2=""
) else (
    set input2="%input2%"
)

:: ------------- help menu --------------- ::
if %action%=="help" (
    echo.
    echo   --------------------------------------------------------------------------------------------------------
    echo    Command Syntax           Arguments       Action taken
    echo   --------------------------------------------------------------------------------------------------------
    echo    rlogin                                   Launches SSH session
    echo    rlogin portal                            Launches SSH session into the VT CS portal
    echo.
    echo    rlogin help                              Displays help menu
    echo.
    echo    rlogin [pulldown/pd]     [src] [dest]    Downloads files from RLogin specified by [src] to the
    echo                                             directory specified by [dest], or to the desktop if
    echo                                             [dest] is left empty
    echo.
    echo    rlogin [pushup/pu]       [src] [dest]    Uploads files from [src] path on Windows to the RLogin
    echo                                             path, inside the home directory, specified by [dest]
    echo   --------------------------------------------------------------------------------------------------------
    
    :: jump out of script
    goto exit
)

:: ------------- logging in -------------- ::
if %action%=="in" (
    echo   Starting SSH Session...
    ssh %g_user%@%g_address%
    
    :: jump out of script
    goto exit
)

if %action%=="portal" (
    echo   Starting SSH Portal Session...
    ssh %g_user%@%g_portal_address%
    
    :: jump out of script
    goto exit
)


:: ---------- pull files down ------------ ::
set pulldown=false
set backup=false
if %action%=="pulldown" ( set pulldown=true )
if %action%=="pd" ( set pulldown=true )
if %pulldown%==true (
    :: check for an empty [src] parametr
    if %input%=="" (
        echo Cannot pull files: please supply a source directory on RLogin
        :: jump to the end of the script
        goto exit
    )
    
    :: create a directory name to dump the files to
    set dumpName=rlogin_pulldown_%date:/=_%_%time::=_%
    set dumpName=!dumpName: =_!
    set dumpName=!dumpName:~0,39!
    
    :: create a full directory path to create the folder
    set dumpPath=%g_defaultdir:"=%!dumpName!
    if not %input2%=="" (
        :: remove "" from the input value and concatenate
        set dumpPath=%input2:"=%\!dumpName!
        :: turn any \\ into \ (in the event the user entered a "\" at the end)
        set dumpPath=!dumpPath:\\=\!
    )
    
    echo   Creating pull-down directory at:    !dumpPath!
    :: if the directory doesn't exist, make it
    if not exist !dumpPath! (
        mkdir !dumpPath!
    )
    
    :: determine the path on RLogin to pull the files from
    set pullPath=%g_homedir:"=%%input:"=%
    
    :: copy the files from rlogin
    echo   Copying files from RLogin at:       !pullPath!
    scp -r %g_user%@%g_address%:!pullPath! !dumpPath!
    
    :: jump out of script
    goto exit
)


:: ----------- push files up ------------- ::
set pushup=false
if %action%=="pushup" ( set pushup=true )
if %action%=="pu" ( set pushup=true )
if %pushup%==true (
    :: check for an empty [src] parametr
    if %input%=="" (
        echo Cannot push files: please supply a source directory on Windows
        :: jump to the end of the script
        goto exit
    )
    
    :: create a directory name to dump the files to on RLogin
    set dumpName=rlogin_pushup_%date:/=_%_%time::=_%
    set dumpName=!dumpName: =_!
    set dumpName=!dumpName:~0,37!
    
    :: create a full path on RLogin to dump the files to
    set dumpPath=%g_homedir:"=%!dumpName!
    if not %input2%=="" (
        :: remove "" from the input value and concatenate
        set dumpPath=%g_homedir:"=%%input2:"=%/!dumpName!
        :: turn any // into / (in the event the user entered a "/" at the end)
        set dumpPath=!dumpPath://=/!
    )
    
    :: determine the path to push files from
    set pushPath=%input:"=%
    
    echo   Pushing files from:
    echo       !pushPath!
    echo   to:
    echo       %g_user:"=%@%g_address:"=%:!dumpPath!
    
    :: push files up to the server
    scp -r !pushPath! %g_user:"=%@%g_address:"=%:!dumpPath!
    
    :: jump out of script
    goto exit
)



:: -------- script exit sequence --------- ::
:exit
echo.
:: finish local-variable session
endlocal
