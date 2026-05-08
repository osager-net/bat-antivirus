@echo off
chcp 1251 >nul
setlocal enabledelayedexpansion
title Windows Control Panel

cls
echo ===========================
echo    WINDOWS CONTROL PANEL
echo ===========================
echo.
echo v0.1 public
echo.

echo You've launched the Windows backup management program. This is designed to bypass viruses that block access to built-in diagnostic and configuration programs. 
echo ATTENTION: The program must be run as administrator, otherwise most commands may be limited.
echo.

:commands
echo Commands:
echo.
echo /restart (Restart your PC)
echo /shutdown (Complete shutdown of the computer)
echo /enablemgr (Allowing the task manager to be opened)
echo /taskmgr (Opening the task manager)
echo /enableconfig (Allowing the system configuration program to be opened)
echo /msconfig (Opening the system configuration program)
echo /sfc (Checking the integrity of files)
echo /dism (Checking the integrity of files. VAR 2)
echo /netstat (Checking the network connection)
echo /tasklist (List of running processes)
echo /taskkill (Terminating a process)
echo /autos (Checking startup items in the Windows registry)
echo /autodel (Removes autostart)
echo /regedit (Opening the Windows Registry Editor)

set /p i="Enter the command: "
echo.
echo.
if "%i%"=="/restart" (goto restart)
if "%i%"=="/shutdown" (goto shutdown)
if "%i%"=="/enablemgr" (goto enablemgr)
if "%i%"=="/taskmgr" (goto taskmgr)
if "%i%"=="/enableconfig" (goto enableconfig)
if "%i%"=="/msconfig" (goto msconfig)
if "%i%"=="/sfc" (goto sfc)
if "%i%"=="/dism" (goto dism)
if "%i%"=="/netstat" (goto netstat)
if "%i%"=="/tasklist" (goto tasklist)
if "%i%"=="/taskkill" (goto taskkill)
if "%i%"=="/autos" (goto autos)
if "%i%"=="/autodel" (goto autodel)
if "%i%"=="/regedit" (goto regedit)
goto noncmd


:next
pause
echo -----------------------------------
goto commands


:restart
echo === RESTART ===
shutdown /r /t 0
if errorlevel 0 (
    echo Successfully rebooting the PC...
) else (
    echo ERROR: Failed to restart your computer
)
goto :eof

:shutdown
echo === SHUTDOWN ===
shutdown /s /t 0
if errorlevel 0 (
    echo We successfully turn off the PC...
) else (
    echo ERROR: Failed to shutdown the computer.
)
goto :eof

:enablemgr
echo === ENABLING TASK MANAGER ===
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f
goto next

:taskmgr
echo === OPEN TASK MANAGER ===
start taskmgr.exe
if errorlevel 0 (
    echo Task Manager is open
) else (
    echo ERROR: Failed to open Task Manager. Try to unblock it or use the tasklist and taskkill commands.
)
goto next

:enableconfig
echo === UNLOCKING MSCONFIG ===
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /v "1" /f
goto next

:msconfig
echo === START MSCONFIG ===
start msconfig.exe
if errorlevel 0 (
    echo Msconfig opened successfully
) else (
    echo ERROR: Failed to open msconfig. Try unlocking it
)
goto next

:sfc
echo === CHECKING FILES VIA SFC ===
echo Please, wait . . .
sfc /scannow
goto next

:dism
echo === CHECKING FILES VIA DISM ===
echo Please, wait . . .
dism /online /cleanup-image /restorehealth
goto next

:netstat
echo === NETSTAT ===
netstat -an
goto next

:tasklist
echo === SHOW TASKLIST ===
tasklist
if errorlevel 0 (
    echo End
) else (
    echo ERROR: Unable to display tasks.
)
goto next

:taskkill
echo === KILL TASK ===
set /p i="Enter the process: "
taskkill /f /im %i%
if errorlevel 0 (
    echo Process %i% completed successfully
) else (
    echo ERROR: The process %i% could not be terminated or does not exist.
)
goto next

:autos
echo === AUTOSTARTS ===
reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run"
goto next

:autodel
echo === DELETE AUTOSTARTS ===
set /p i="Enter unnecessary startup: "
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run" /v "%i%" /f
goto next

:regedit
echo === START REGEDIT ===
start regedit.exe
if errorlevel 0 (
    echo Regedit has been successfully opened.
) else (
    echo ERROR: Failed to start regedit
)
goto next

:noncmd
echo ERROR: The command does not exist or there was a typo.
goto next
