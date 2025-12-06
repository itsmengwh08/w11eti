@echo off
CD /d %~dp0
title Windows 11 Education Theme Installer
echo.
echo Created by itsmengwh08
echo https://github.com/itsmengwh08/w11eti
echo.
echo ============================================================
echo Modifying registry...
echo ============================================================
echo.
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Education" /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Education" /v EnableEduThemes /t REG_DWORD /d 0 /f
echo.
echo ============================================================
echo Installing theme...
echo ============================================================
echo.
powershell -ExecutionPolicy Bypass -Command "Add-AppxPackage SunsetLight.Appx"
powershell -ExecutionPolicy Bypass -Command "Add-AppxPackage SunsetDark.Appx"
powershell -ExecutionPolicy Bypass -Command "Add-AppxPackage PlanetsLight.Appx"
powershell -ExecutionPolicy Bypass -Command "Add-AppxPackage PlanetsDark.Appx"
powershell -ExecutionPolicy Bypass -Command "Add-AppxPackage FlowerLight.Appx"
powershell -ExecutionPolicy Bypass -Command "Add-AppxPackage FlowerDark.Appx"
echo.
start ms-settings:themes
echo Installation complete! Themes should show in the Settings
echo.
pause