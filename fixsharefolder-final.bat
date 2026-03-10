:fixguest
echo Resetting Local Group Policy...

RD /S /Q "%WinDir%\System32\GroupPolicy"
RD /S /Q "%WinDir%\System32\GroupPolicyUsers"

gpupdate /force

echo Enabling Insecure Guest Logon...

reg add HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters /v AllowInsecureGuestAuth /t REG_DWORD /d 1 /f

net stop LanmanWorkstation /y
net start LanmanWorkstation

echo Done
pause
goto menu