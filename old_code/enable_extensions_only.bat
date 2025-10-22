@echo off
echo ========================================
echo Enable Unsigned Extensions for After Effects
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

echo Enabling unsigned extensions for After Effects...
echo.

REM Enable unsigned extensions
regedit /s "%SCRIPT_DIR%enable_unsigned_extensions.reg"

if %errorLevel% == 0 (
    echo.
    echo ========================================
    echo Extensions enabled successfully!
    echo ========================================
    echo.
    echo Unsigned extensions are now enabled for After Effects.
    echo.
    echo Next steps:
    echo 1. Restart After Effects completely
    echo 2. Your custom extensions should now appear in:
    echo    Window ^> Extensions
    echo.
    echo To disable unsigned extensions later, run:
    echo disable_unsigned_extensions.reg
    echo.
) else (
    echo.
    echo ========================================
    echo Failed to enable extensions!
    echo ========================================
    echo.
    echo There was an error modifying the registry.
    echo Please try running the registry file manually:
    echo enable_unsigned_extensions.reg
    echo.
)

echo Press any key to exit...
pause >nul

