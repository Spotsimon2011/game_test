@echo off
title Seven Nexus Shortcut Creator
set "exeRelPath=SevenNexus.exe"
set "shortcutName=Seven Nexus"
set "desktop=%USERPROFILE%\Desktop"
set "targetExe=%~dp0%exeRelPath%"

if not exist "%targetExe%" (
   echo ERROR: Could not find %targetExe%
   echo Make sure this file is in the same folder as the game.
   pause
   exit /b
)

echo Creating shortcut for %shortcutName%...
set "vbs=%temp%\create_shortcut.vbs"

> "%vbs%" echo Set oWS = WScript.CreateObject("WScript.Shell")
>> "%vbs%" echo sLinkFile = "%desktop%\%shortcutName%.lnk"
>> "%vbs%" echo Set oLink = oWS.CreateShortcut(sLinkFile)
>> "%vbs%" echo oLink.TargetPath = "%targetExe%"
>> "%vbs%" echo oLink.WorkingDirectory = "%~dp0"
>> "%vbs%" echo oLink.IconLocation = "%targetExe%,0"
>> "%vbs%" echo oLink.Save

cscript //nologo "%vbs%"
del "%vbs%" 2>nul

echo [OK] Shortcut created on Desktop
pause
