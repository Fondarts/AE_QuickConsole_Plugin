@echo off
echo ========================================
echo AE Quick Console Plugin - Complete Fix
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

echo This script will:
echo 1. Run diagnostics
echo 2. Install plugin to all locations
echo 3. Enable unsigned extensions
echo 4. Restart After Effects
echo.

echo Press any key to continue or close this window to cancel...
pause >nul

echo.
echo Step 1: Running diagnostics...
call diagnose.bat

echo.
echo Step 2: Installing plugin to all locations...
call install_all_locations.bat

echo.
echo Step 3: Enabling unsigned extensions...
regedit /s "%~dp0enable_unsigned_extensions.reg"

echo.
echo Step 4: Restarting After Effects...
call restart_ae.bat

echo.
echo ========================================
echo Complete Fix Process Finished!
echo ========================================
echo.

echo The plugin should now be available in:
echo Window ^> Extensions ^> AE Quick Console
echo.

echo If the plugin still doesn't appear:
echo 1. Check the After Effects console for errors (Window ^> Console)
echo 2. Try running diagnose.bat again
echo 3. Check if your After Effects version is supported
echo.

echo Press any key to exit...
pause >nul

