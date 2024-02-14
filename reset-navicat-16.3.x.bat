@echo off
setlocal
echo Reset Navicat remaining 14 days trial  
echo.
set update=HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium\Update

echo 1) Delete HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium\Update
echo delete: %update%
reg delete %update% /va /f
echo.

echo 2) Delete HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium\Registration[version and language]
for /f %%i in ('"REG QUERY "HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium" /s | findstr /L Registration"') do (
    echo delete: %%i
    reg delete %%i /va /f
)
echo.

echo 3) Delete  folder including Info  under HKEY_CURRENT_USER\Software\Classes\CLSID
for /f %%i in ('"REG QUERY "HKEY_CURRENT_USER\Software\Classes\CLSID" /s | findstr /E Info"') do (
    set "all_info=%%i"
)
if defined all_Info (
    echo info:  %all_info%
    setlocal EnableDelayedExpansion
    set "p_info=%all_info:~0,-5%"
    echo delete: !p_info!
    reg delete !p_info!  /f
) else (
        echo "no item found"
)
echo.

echo 4) Delete  folder including ShellFolder  under HKEY_CURRENT_USER\Software\Classes\CLSID
for /f %%i in ('"REG QUERY "HKEY_CURRENT_USER\Software\Classes\CLSID" /s | findstr /E ShellFolder"') do (
    set "all_ShellFolder=%%i"
)
if not "%all_ShellFolder%"=="" (
    echo ShellFolder:  %all_ShellFolder%
    set p_ShellFolder=%all_ShellFolder:~0,-12%
) else ( echo "no item found" )

if not "%p_ShellFolder%"=="" (
    echo delete: %p_ShellFolder%
    reg delete %p_ShellFolder%  /f
)
echo.

echo Finish, Enjoy it !
endlocal
pause
