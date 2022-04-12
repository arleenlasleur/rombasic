@echo off
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)
if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params= %*
echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit /B
:gotAdmin
pushd "%CD%"
CD /D "%~dp0"
rem === PS2 autodowload =================
echo Start-BitsTransfer -Source https://github.com/arleenlasleur/rombasic/blob/main/tvnc2859x86.msi -Destination tvnc.2859x86.msi>gettvn.ps1
powershell -executionpolicy unrestricted -file gettvn.ps1
del gettvn.ps1
rem =====================================
set vncopt1=SET_ACCEPTHTTPCONNECTIONS=1 VALUE_OF_ACCEPTHTTPCONNECTIONS=0 SET_GRABTRANSPARENTWINDOWS=1 VALUE_OF_GRABTRANSPARENTWINDOWS=1 SET_REMOVEWALLPAPER=1 VALUE_OF_REMOVEWALLPAPER=0
set vncopt2=SET_IPACCESSCONTROL=1 VALUE_OF_IPACCESSCONTROL=0.0.0.0-25.255.255.255:1,26.0.0.0-26.255.255.255:0,27.0.0.0-255.255.255.255:1
set vncopt3=SET_RUNCONTROLINTERFACE=1 VALUE_OF_RUNCONTROLINTERFACE=0 SET_USECONTROLAUTHENTICATION=1 VALUE_OF_USECONTROLAUTHENTICATION=1
set vncopt4=SET_CONTROLPASSWORD=1 VALUE_OF_CONTROLPASSWORD=ZaTJKv80 SET_PASSWORD=1 VALUE_OF_PASSWORD=ZaTJKv80 SET_VIEWONLYPASSWORD=1 VALUE_OF_VIEWONLYPASSWORD=ZaTJKv80
msiexec /i tvnc2859x86.msi /quiet /norestart ADDLOCAL=Server INSTALLDIR="C:\Program Files\TVNC" %vncopt1% %vncopt2% %vncopt3% %vncopt4%
echo REGEDIT4>tvnprops.reg
echo.>>tvnprops.reg
echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM]>>tvnprops.reg
echo "UseMachineCheck"=dword:00000000>>tvnprops.reg
echo "Blur"=dword:00000000>>tvnprops.reg
echo "Animations"=dword:00000000>>tvnprops.reg
echo.>>tvnprops.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]>>tvnprops.reg
echo "tvncontrol"=->>tvnprops.reg
echo.>>tvnprops.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{967FE692-A933-45CF-AF62-4E7862006042}]>>tvnprops.reg
echo.>>tvnprops.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{C148910C-51F8-4D36-BFBD-87A64B139006}]>>tvnprops.reg
echo.>>tvnprops.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{D903B276-81AE-4AED-AEF9-45DACFBF16CE}]>>tvnprops.reg
echo.>>tvnprops.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{55A53357-8C45-4AFA-A415-247A8B167F60}]>>tvnprops.reg
echo.>>tvnprops.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{47511BB5-0C77-46DF-86B6-6D21DE2F3F50}]>>tvnprops.reg
echo.>>tvnprops.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{8A396897-3AC8-46BD-ABB8-95BE31419FDE}]>>tvnprops.reg
echo.>>tvnprops.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{9D4D0556-7368-4A1E-817B-2C4E3FA61440}]>>tvnprops.reg
echo.>>tvnprops.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{DEE0B752-52D8-4615-9BEE-1EDA46628960}]>>tvnprops.reg
echo.>>tvnprops.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{4E75CBD3-C0CE-44BB-BC77-1D30493A16BB}]>>tvnprops.reg
echo.>>tvnprops.reg
echo [-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{D8B3585B-BB20-4BDC-9939-628B659D0BD6}]>>tvnprops.reg
reg import tvnprops.reg
del tvnprops.reg
chcp 866
set sysprofiledir=C:\Users
set profileprogdir=\Start menu\Programs
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC" del /s /q "%sysprofiledir%\All Users%profileprogdir%\TightVNC" >nul
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Application Mode)" rd "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Application Mode)" >nul
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Service Mode)" rd "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Service Mode)" >nul
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC" rd "%sysprofiledir%\All Users%profileprogdir%\TightVNC" >nul
set sysprofiledir=C:\Documents and settings
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC" del /s /q "%sysprofiledir%\All Users%profileprogdir%\TightVNC" >nul
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Application Mode)" rd "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Application Mode)" >nul
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Service Mode)" rd "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Service Mode)" >nul
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC" rd "%sysprofiledir%\All Users%profileprogdir%\TightVNC" >nul
set profileprogdir=\Главное меню\Программы
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC" del /s /q "%sysprofiledir%\All Users%profileprogdir%\TightVNC" >nul
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Application Mode)" rd "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Application Mode)" >nul
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Service Mode)" rd "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Service Mode)" >nul
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC" rd "%sysprofiledir%\All Users%profileprogdir%\TightVNC" >nul
set sysprofiledir=C:\Users
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC" del /s /q "%sysprofiledir%\All Users%profileprogdir%\TightVNC" >nul
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Application Mode)" rd "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Application Mode)" >nul
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Service Mode)" rd "%sysprofiledir%\All Users%profileprogdir%\TightVNC\TightVNC Server (Service Mode)" >nul
if exist "%sysprofiledir%\All Users%profileprogdir%\TightVNC" rd "%sysprofiledir%\All Users%profileprogdir%\TightVNC" >nul
cls
echo Done.
echo.
sc query tvnserver
tasklist | find "tvn" /i
ipconfig | find "26." /i
netstat -a | find "5900" /i
echo.
pause
