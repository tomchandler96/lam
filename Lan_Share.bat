@echo off
title LAN SHARE TOOL - IT SUPPORT
color 0A

:menu
cls
echo ===============================
echo        LAN SHARE TOOL
echo ===============================
echo 1. Cai dat MAY CHIA SE (May con)
echo 2. Ket noi MAY CHU (Map o mang)
echo 3. Reset mang
echo 4. Mo thu muc chia se
echo 5. Xem IP may
echo 0. Thoat
echo ===============================

set /p choice=Chon chuc nang: 

if %choice%==1 goto share
if %choice%==2 goto connect
if %choice%==3 goto resetnet
if %choice%==4 goto open
if %choice%==5 goto ip
if %choice%==0 exit

goto menu


:share
cls
echo Dang cai dat may chia se...

:: Bat Network Discovery
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes

:: Bat File Sharing
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes

:: Bat SMB Server
sc config lanmanserver start= auto
net start lanmanserver

:: Tat password sharing
reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /v everyoneincludesanonymous /t REG_DWORD /d 1 /f

:: Share o D
net share DATA=D:\ /grant:everyone,full

echo ===============================
echo Da chia se o D voi ten DATA
echo Truy cap bang: \\IP-MAY-CON\DATA
echo ===============================
pause
goto menu


:connect
cls
set /p ip=Nhap IP may chia se: 

net use Z: \\%ip%\DATA /persistent:yes

echo ===============================
echo Da map o mang Z:
echo ===============================
pause
goto menu


:resetnet
cls
echo Dang reset mang...

ipconfig /release
ipconfig /flushdns
ipconfig /renew
netsh winsock reset
netsh int ip reset

echo Reset xong. Nen restart may.
pause
goto menu


:open
cls
set /p ip=Nhap IP may chia se: 
start \\%ip%
goto menu


:ip
ipconfig
pause
goto menu