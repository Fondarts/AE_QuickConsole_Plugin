@echo off
echo ========================================
echo   AE QuickConsole Plugin V31
echo   PARENT AND TRACK MATTE COMMANDS
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
echo [2/4] Copying new V31 files...
xcopy /E /I /Y "%~dp0" "%APPDATA%\Adobe\CEP\extensions\AE_QuickConsole_Plugin"
if %errorlevel% equ 0 (
    echo ✓ V31 files copied successfully
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
echo   V31 CHANGELOG - PARENT & TRACK MATTE
echo ========================================
echo.
echo NEW COMMANDS ADDED:
echo   • parent to 5        → Emparenta capas seleccionadas a capa 5
echo   • track matte 3      → Establece track matte alpha con capa 3
echo.
echo USAGE EXAMPLES:
echo   1. Select layers you want to parent
echo   2. Type "parent to" and press Enter
echo   3. Type "5" and press Enter (to parent to layer 5)
echo.
echo   1. Select layers you want to set track matte
echo   2. Type "track matte" and press Enter  
echo   3. Type "3" and press Enter (to use layer 3 as track matte)
echo.
echo FEATURES:
echo   • Two-step command system (command + Enter, then parameters + Enter)
echo   • Works with multiple selected layers
echo   • Prevents self-parenting and self-track matte
echo   • Clear error messages and success feedback
echo   • Undo support for all operations
echo.
echo ========================================
echo   RESTART AFTER EFFECTS TO USE V31
echo ========================================
echo.
pause
