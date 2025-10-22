@echo off
echo ========================================
echo AE Quick Console Plugin - Syntax Fix
echo ========================================
echo.

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [OK] Running with administrator privileges
) else (
    echo [ERROR] This script requires administrator privileges
    echo Please right-click and select "Run as administrator"
    pause
    exit /b 1
)

echo Fixing JSX syntax errors...
echo.

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "PLUGIN_NAME=AE_QuickConsole_Plugin"

REM Define CEP extensions directories
set "SYSTEM_CEP_DIR=%PROGRAMDATA%\Adobe\CEP\extensions"
set "USER_CEP_DIR=%APPDATA%\Adobe\CEP\extensions"

echo Updating plugin files with syntax fixes...
echo.

REM Update system installation
if exist "%SYSTEM_CEP_DIR%\%PLUGIN_NAME%" (
    echo Updating system installation...
    xcopy "%SCRIPT_DIR%*" "%SYSTEM_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q
    if %errorLevel% == 0 (
        echo [OK] System installation updated
    ) else (
        echo [ERROR] System installation update failed
    )
)

REM Update user installation
if exist "%USER_CEP_DIR%\%PLUGIN_NAME%" (
    echo Updating user installation...
    xcopy "%SCRIPT_DIR%*" "%USER_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q
    if %errorLevel% == 0 (
        echo [OK] User installation updated
    ) else (
        echo [ERROR] User installation update failed
    )
)

echo.
echo ========================================
echo Syntax Fix Complete!
echo ========================================
echo.

echo Changes made:
echo - Fixed JSX syntax errors
echo - Added proper function wrapping
echo - Added syntax testing
echo - Improved error handling
echo.

echo Next steps:
echo 1. Restart After Effects completely
echo 2. Test the plugin commands
echo 3. The plugin should now work without syntax errors
echo.

echo Press any key to exit...
pause >nul

