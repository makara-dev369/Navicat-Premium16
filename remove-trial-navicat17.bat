@echo off
setlocal enabledelayedexpansion

echo Deleting HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium\Registration17XEN...
reg delete "HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium\Registration17XEN" /f > nul 2>&1

echo.

echo Deleting parent folders of keys ending with \Info under HKEY_CURRENT_USER\Software\Classes\CLSID...
for /f "tokens=*" %%i in ('REG QUERY "HKEY_CURRENT_USER\Software\Classes\CLSID" /s /f "Info" ^| findstr /I "\\Info$"') do (
    set "key=%%i"
    set "parent=!key:~0,-5!"
    echo Deleting !parent! ...
    reg delete "!parent!" /f > nul 2>&1
)

echo.

echo Deleting parent folders of keys ending with \InprocServer32 under HKEY_CURRENT_USER\Software\Classes\CLSID...
for /f "tokens=*" %%i in ('REG QUERY "HKEY_CURRENT_USER\Software\Classes\CLSID" /s /f "InprocServer32" ^| findstr /I "\\InprocServer32$"') do (
    set "key=%%i"
    set "parent=!key:~0,-15!"
    echo Deleting !parent! ...
    reg delete "!parent!" /f > nul 2>&1
)

echo.

echo Deleting parent folders of keys ending with \ShellFolder under HKEY_CURRENT_USER\Software\Classes\CLSID...
for /f "tokens=*" %%j in ('REG QUERY "HKEY_CURRENT_USER\Software\Classes\CLSID" /s /f "ShellFolder" ^| findstr /I "\\ShellFolder$"') do (
    set "key=%%j"
    set "parent=!key:~0,-12!"
    echo Deleting !parent! ...
    reg delete "!parent!" /f > nul 2>&1
)

echo.

echo Finished.
pause
