@echo off
echo ========================================
echo   AE QuickConsole Plugin V32
echo   TWO-STEP COMMAND FIX
echo ========================================
echo.

echo [1/4] Removing previous version...
if exist "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin" (
    rmdir /s /q "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
    echo ✓ Previous version removed
) else (
    echo ✓ No previous version found
)

echo.
echo [2/4] Copying new V32 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V32 files copied successfully
) else (
    echo ✗ Error copying files
    pause
    exit /b 1
)

echo.
echo [3/4] Enabling unsigned extensions...
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.11" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.12" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Adobe\CSXS.13" /v PlayerDebugMode /t REG_SZ /d "1" /f >nul 2>&1
echo ✓ Unsigned extensions enabled

echo.
echo [4/4] Installation complete!
echo.
echo ========================================
echo   V32 CHANGELOG - TWO-STEP FIX
echo ========================================
echo.
echo FIXED ISSUES:
echo   • parent to command now properly clears input field
echo   • track matte command now properly clears input field
echo   • Two-step command system working correctly
echo   • Proper detection of parameter-required commands
echo.
echo HOW IT WORKS NOW:
echo   1. Type "parent to" and press Enter
echo   2. Input field clears automatically
echo   3. Type layer number (e.g., "5") and press Enter
echo   4. Command executes successfully
echo.
echo   1. Type "track matte" and press Enter
echo   2. Input field clears automatically  
echo   3. Type layer number (e.g., "3") and press Enter
echo   4. Command executes successfully
echo.
echo COMMANDS WITH TWO-STEP LOGIC:
echo   • parent to        → Needs parent layer number
echo   • track matte      → Needs track matte layer number
echo   • select           → Needs layer numbers
echo   • solo             → Needs layer numbers (or uses selected)
echo   • motion blur      → Needs layer numbers
echo   • 3d layer         → Needs layer numbers
echo   • hide, show, mute, unmute, audio, lock, unlock, shy, unshy
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V32
echo ========================================
echo.
pause
