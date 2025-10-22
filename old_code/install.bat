@echo off
echo ========================================
echo AE Quick Console Plugin Installer
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

echo Installing AE Quick Console Plugin...
echo.

REM Define CEP extensions directory
set "CEP_DIR=%PROGRAMDATA%\Adobe\CEP\extensions"

REM Create CEP extensions directory if it doesn't exist
if not exist "%CEP_DIR%" (
    echo Creating CEP extensions directory...
    mkdir "%CEP_DIR%"
)

REM Copy plugin to CEP extensions directory
echo Copying plugin files...
xcopy "%SCRIPT_DIR%*" "%CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q

REM Enable unsigned extensions
echo Enabling unsigned extensions...
regedit /s "%SCRIPT_DIR%enable_unsigned_extensions.reg"

if %errorLevel% == 0 (
    echo.
    echo ========================================
    echo Installation completed successfully!
    echo ========================================
    echo.
    echo The AE Quick Console plugin has been installed.
    echo.
    echo To use the plugin:
    echo 1. Restart After Effects
    echo 2. Go to Window ^> Extensions ^> AE Quick Console
    echo.
    echo Unsigned extensions have been automatically enabled.
    echo If the plugin still doesn't appear, try:
    echo 1. Restart After Effects completely
    echo 2. Check that the plugin is in: %CEP_DIR%\%PLUGIN_NAME%
    echo 3. Run enable_unsigned_extensions.reg manually if needed
    echo.
) else (
    echo.
    echo ========================================
    echo Installation failed!
    echo ========================================
    echo.
    echo There was an error copying the plugin files.
    echo Please check the permissions and try again.
    echo.
)

echo Press any key to exit...
pause >nul
