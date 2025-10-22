@echo off
echo ========================================
echo AE Quick Console Plugin - Multi-Location Installer
echo ========================================
echo.

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running with administrator privileges...
) else (
    echo This script requires administrator privileges.
    echo Please right-click and select "Run as administrator"
    pause
    exit /b 1
)

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "PLUGIN_NAME=AE_QuickConsole_Plugin"

echo Installing AE Quick Console Plugin to all possible locations...
echo.

REM Define multiple CEP extensions directories
set "SYSTEM_CEP_DIR=%PROGRAMDATA%\Adobe\CEP\extensions"
set "USER_CEP_DIR=%APPDATA%\Adobe\CEP\extensions"
set "USER_CEP_DIR2=%LOCALAPPDATA%\Adobe\CEP\extensions"

echo Installing to multiple locations:
echo 1. System: %SYSTEM_CEP_DIR%
echo 2. User: %USER_CEP_DIR%
echo 3. Local User: %USER_CEP_DIR2%
echo.

REM Create directories if they don't exist
if not exist "%SYSTEM_CEP_DIR%" (
    echo Creating system CEP directory...
    mkdir "%SYSTEM_CEP_DIR%"
)

if not exist "%USER_CEP_DIR%" (
    echo Creating user CEP directory...
    mkdir "%USER_CEP_DIR%"
)

if not exist "%USER_CEP_DIR2%" (
    echo Creating local user CEP directory...
    mkdir "%USER_CEP_DIR2%"
)

REM Copy to system directory
echo Copying to system directory...
xcopy "%SCRIPT_DIR%*" "%SYSTEM_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q
if %errorLevel% == 0 (
    echo [OK] System installation successful
) else (
    echo [ERROR] System installation failed
)

REM Copy to user directory
echo Copying to user directory...
xcopy "%SCRIPT_DIR%*" "%USER_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q
if %errorLevel% == 0 (
    echo [OK] User installation successful
) else (
    echo [ERROR] User installation failed
)

REM Copy to local user directory
echo Copying to local user directory...
xcopy "%SCRIPT_DIR%*" "%USER_CEP_DIR2%\%PLUGIN_NAME%\" /E /I /Y /Q
if %errorLevel% == 0 (
    echo [OK] Local user installation successful
) else (
    echo [ERROR] Local user installation failed
)

REM Enable unsigned extensions
echo Enabling unsigned extensions...
regedit /s "%SCRIPT_DIR%enable_unsigned_extensions.reg"

echo.
echo ========================================
echo Multi-Location Installation Complete!
echo ========================================
echo.

echo Plugin installed to:
echo - %SYSTEM_CEP_DIR%\%PLUGIN_NAME%
echo - %USER_CEP_DIR%\%PLUGIN_NAME%
echo - %USER_CEP_DIR2%\%PLUGIN_NAME%
echo.

echo Next steps:
echo 1. Restart After Effects completely
echo 2. Go to Window ^> Extensions ^> AE Quick Console
echo 3. If still not working, run diagnose.bat
echo.

echo Press any key to exit...
pause >nul

