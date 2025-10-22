@echo off
echo ========================================
echo AE Quick Console Plugin - User Installation
echo ========================================
echo.

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "PLUGIN_NAME=AE_QuickConsole_Plugin"

echo Installing AE Quick Console Plugin to user directory...
echo.

REM Define user CEP extensions directory
set "USER_CEP_DIR=%APPDATA%\Adobe\CEP\extensions"

REM Create user CEP extensions directory if it doesn't exist
if not exist "%USER_CEP_DIR%" (
    echo Creating user CEP extensions directory...
    mkdir "%USER_CEP_DIR%"
)

REM Copy plugin to user CEP extensions directory
echo Copying plugin files to user directory...
xcopy "%SCRIPT_DIR%*" "%USER_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q

REM Enable unsigned extensions
echo Enabling unsigned extensions...
regedit /s "%SCRIPT_DIR%enable_unsigned_extensions.reg"

if %errorLevel% == 0 (
    echo.
    echo ========================================
    echo Installation completed successfully!
    echo ========================================
    echo.
    echo The AE Quick Console plugin has been installed to:
    echo %USER_CEP_DIR%\%PLUGIN_NAME%
    echo.
    echo To use the plugin:
    echo 1. Restart After Effects
    echo 2. Go to Window ^> Extensions ^> AE Quick Console
    echo.
    echo Unsigned extensions have been automatically enabled.
    echo If the plugin still doesn't appear, try:
    echo 1. Restart After Effects completely
    echo 2. Run diagnose.bat to check installation
    echo 3. Try the system-wide installation with install.bat
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

