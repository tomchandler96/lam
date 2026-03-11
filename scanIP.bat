@echo off
title IP Range Scanner
color 0A
cls

echo =====================================
echo            IP RANGE SCANNER
echo =====================================
echo.

set /p start=Enter START IP (example 192.168.1.1): 
set /p end=Enter END IP (example 192.168.1.254): 

echo.
echo Scanning network, please wait...
echo =====================================
echo.

for /f "tokens=1-4 delims=." %%a in ("%start%") do (
set net=%%a.%%b.%%c
set startip=%%d
)

for /f "tokens=4 delims=." %%a in ("%end%") do (
set endip=%%a
)

for /l %%i in (%startip%,1,%endip%) do (

ping -n 1 -w 120 %net%.%%i >nul

if errorlevel 1 (
echo %net%.%%i  --- AVAILABLE
) else (
echo %net%.%%i  --- IN USE
)

)

echo.
echo =====================================
echo Scan completed
echo =====================================
pause