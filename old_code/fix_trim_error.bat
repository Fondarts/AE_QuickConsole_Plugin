@echo off
echo ========================================
echo Fix Trim Error
echo ========================================
echo.

REM Get the directory where this script is located
set "SCRIPT_DIR=%~dp0"
set "PLUGIN_NAME=AE_QuickConsole_Plugin"

echo Fixing trim() error in JSX...
echo.

REM Define user CEP extensions directory
set "USER_CEP_DIR=%APPDATA%\Adobe\CEP\extensions"

echo Copying corrected files to user directory...
xcopy "%SCRIPT_DIR%*" "%USER_CEP_DIR%\%PLUGIN_NAME%\" /E /I /Y /Q

if %errorLevel% == 0 (
    echo.
    echo ========================================
    echo Trim Error Fixed Successfully!
    echo ========================================
    echo.
    echo The trim() error has been fixed.
    echo.
    echo Next steps:
    echo 1. Restart After Effects completely
    echo 2. Go to Window ^> Extensions ^> Command Console
    echo 3. Try the commands again - they should work now
    echo.
    echo The error was caused by using trim() which doesn't exist in After Effects JSX.
    echo Now it uses standard JavaScript string handling.
    echo.
) else (
    echo.
    echo ========================================
    echo Fix failed!
    echo ========================================
    echo.
    echo There was an error copying the files.
    echo Please try again.
    echo.
)

echo Press any key to exit...
pause >nul

